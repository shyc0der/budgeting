// ignore_for_file: file_names

import 'package:budget/src/input.dart';
import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/modules/monthlyIncome.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMonthlyIncome extends StatefulWidget {
  const AddMonthlyIncome({Key? key}) : super(key: key);

  @override
  _AddMonthlyIncomeState createState() => _AddMonthlyIncomeState();
}

class _AddMonthlyIncomeState extends State<AddMonthlyIncome> {
  TextEditingController salaryController = TextEditingController();
  final MonthlyIncomeModule _monthlyIncomeModule = MonthlyIncomeModule();

  bool nameError = false;
  bool amountError = false;
  bool isLoading = false;
  bool errorExists = false;
  late String selectedDate = DateTime.now().toString();
  List<Map<String, dynamic>> _res = [
    {
      'item': {'name': 'shopping', 'amount': 100}
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    _res.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPage(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 30,
              ),
              //icon
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                    size: 27,
                  )),

              const SizedBox(
                height: 60,
              ),
              //Text
              const Text(
                'ADD MONTHLY INCOME',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              //name
              inputField('MONTHLY INCOME', salaryController, nameError,
                  isNumbers: true, onChanged: (val) {
                if (val.isNotEmpty) {
                  setState(() {
                    nameError = false;
                  });
                }
              }),

              const SizedBox(
                height: 10,
              ),

              // YEAR and MONTH
              DateTimePicker(
                initialValue: selectedDate.toString(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2122),
                dateLabelText: 'Date',
                onChanged: (value) {
                  setState(() {
                    selectedDate = value;
                  });
                },
                initialDatePickerMode: DatePickerMode.year,
              ),

              const SizedBox(
                height: 10,
              ),

              //Amount Budgeted
              // ADD A LIST OF INCOMES
              // Name,Amount
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  onPressed: () async {
                    List<Map<String, dynamic>> res;

                    res = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: AddExtraIncome(),
                          );
                        });
                    setState(() {
                      _res = res;
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('ADD EXTRA INCOME')),
              //TODO: ADD INCOME
// add button
//listview of the incomes
              const SizedBox(
                height: 12,
              ),

              Expanded(
                  child: _res.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('INCOMES'),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: _res.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SingleChildScrollView(
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Dismissible(
                                            key: UniqueKey(),
                                            direction:
                                                DismissDirection.endToStart,
                                            onDismissed: (_) {
                                              setState(() {
                                                _res.removeAt(index);
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(_res[index]['item']['name']
                                                    .toString()),
                                                Text(_res[index]['item']
                                                        ['amount']
                                                    .toString()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                      : Container()),
              //TODO: MONTH
              const SizedBox(height: 36),
              //Save
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomElavtedButton(
                    errorExists: errorExists,
                    label: 'CANCEL',
                    fontSize: 15,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomElavtedButton(
                    errorExists: errorExists,
                    label: 'ADD INCOME',
                    fontSize: 15,
                    onTap: () {
                      if (salaryController.text.isEmpty) {
                        setState(() {
                          nameError = true;
                        });
                        errorExists = true;
                      }

                      if (!errorExists) {
                        addIncome();
                      }
                    },
                  ),
                ),
              ])
            ]),
          ),
        ],
      ),
    );
  }

  void addIncome() async {
    setState(() {
      isLoading = true;
    });
  
    var res = await _monthlyIncomeModule.addIncome(MonthlyIncomeModel(
        salary: salaryController.text,
        extraIncome: _res,
        createdBy: 'Steady',
        month: DateTime.parse(selectedDate),
        dateCreated: DateTime.now()
        )
        );
    if (res.status == ResponseType.success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Income Added Sucessfully')));
      Navigator.pop(context);
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: res.body.toString(),
        backgroundColor: Colors.redAccent,
      ));
    }
  }
}

class AddExtraIncome extends StatefulWidget {
  const AddExtraIncome({Key? key}) : super(key: key);

  @override
  State<AddExtraIncome> createState() => _AddExtraIncomeState();
}

class _AddExtraIncomeState extends State<AddExtraIncome> {
  TextEditingController extraIncomeController = TextEditingController();
  TextEditingController extraIncomeAmountController = TextEditingController();
  bool extraAmountError = false;
  bool extraNameError = false;
  bool errorExists = false;
  final List<Map<String, dynamic>> asmap = [
    {
      'item': {'name': 'shopping', 'amount': 100},
    }
  ];
  @override
  void initState() {
    asmap.clear();
    super.initState();
  }

  void addItemsToList() {
    setState(() {
      asmap.add({
        'item': {
          'name': extraIncomeController.text,
          'amount': extraIncomeAmountController.text
        }
      });
    });
    extraIncomeAmountController.clear();
    extraIncomeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Add Extra Income'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          //INCOME NAME
          inputField(
            'Extra Income Description',
            extraIncomeController,
            extraNameError,
            onChanged: (val) {
              if (val.isNotEmpty) {
                setState(() {
                  extraNameError = false;
                });
              }
            },
          ),
          //AMOUNT
          inputField('Amount', extraIncomeAmountController, extraAmountError,
              isNumbers: true, onChanged: (val) {
            if (val.isNotEmpty) {
              setState(() {
                extraAmountError = false;
              });
            }
          }),
          const SizedBox(
            height: 15,
          ),

          //ADD BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: CustomElavtedButton(
                  errorExists: errorExists,
                  label: 'CANCEL',
                  fontSize: 15,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomElavtedButton(
                  errorExists: errorExists,
                  label: 'Add Exta Income',
                  fontSize: 15,
                  onTap: () {
                    if (extraIncomeAmountController.text.isEmpty) {
                      setState(() {
                        extraAmountError = true;
                      });
                      errorExists = true;
                    }
                    if (extraIncomeController.text.isEmpty) {
                      setState(() {
                        extraNameError = true;
                      });
                      errorExists = true;
                    }

                    if (!errorExists) {
                      addItemsToList();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),

          Expanded(
            child: Column(
              children: [
                const Text('INCOMES'),
                Expanded(
                    child: asmap.isNotEmpty
                        ? ListView.builder(
                            //shrinkWrap: true,
                            itemCount: asmap.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Dismissible(
                                      key: UniqueKey(),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (_) {
                                        setState(() {
                                          asmap.removeAt(index);
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(asmap[index]['item']['name']),
                                          Text(asmap[index]['item']['amount']
                                              .toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Container(
                            height: 10,
                            child: const Center(
                              child: Text('Please Add Incomes'),
                            ),
                          )),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomElavtedButton(
                    errorExists: errorExists,
                    label: 'Save',
                    fontSize: 15,
                    onTap: () {
                      Navigator.of(context).pop(asmap);
                    },
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
