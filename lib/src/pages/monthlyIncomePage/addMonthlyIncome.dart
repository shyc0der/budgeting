// ignore_for_file: file_names

import 'package:budget/src/input.dart';
import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/modules/monthlyIncome.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:budget/src/modules/userModule.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMonthlyIncome extends StatefulWidget {
  const AddMonthlyIncome({this.incomeModel, this.isEditing = false, Key? key})
      : super(key: key);
  final bool isEditing;
  final MonthlyIncomeModel? incomeModel;

  @override
  _AddMonthlyIncomeState createState() => _AddMonthlyIncomeState();
}

class _AddMonthlyIncomeState extends State<AddMonthlyIncome> {
  TextEditingController salaryController = TextEditingController();
  final MonthlyIncomeModule _monthlyIncomeModule = MonthlyIncomeModule();
  UserModule userModel = Get.put(UserModule());

  final BudgetCategoryModule _budgetCategoryModule = BudgetCategoryModule();

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
    _res.clear();
    if (widget.isEditing) {
      salaryController.text = widget.incomeModel?.salary ?? '';
      selectedDate = (widget.incomeModel?.month ?? DateTime.now()).toString();
      _res = widget.incomeModel!.extraIncome!;
    }

    _budgetCategoryModule.init(userModel.currentUser.value);
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
              Text(
                '${widget.isEditing ? 'EDIT' : 'ADD'} MONTHLY INCOME',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              //name
              inputField('SALARY/MAIN INCOME', salaryController, nameError,
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
                    primary: const Color.fromRGBO(85, 54, 33, 1),
                  ),
                  onPressed: () async {
                    List<Map<String, dynamic>> res;

                    res = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: AddExtraIncome(
                              currentExtraIncomes: _res,
                            ),
                          );
                        });
                    setState(() {
                      _res = res;
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('ADD EXTRA INCOME')),

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
                                            onDismissed: (_) async{
                                                    _res.removeAt(index);
                                             await   _monthlyIncomeModule
                                                    .deleteIncomeIncome(
                                                        widget.incomeModel!.id,
                                                        index.toString());
                                              
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
                    label: '${widget.isEditing ? 'EDIT' : 'ADD'} INCOME',
                    fontSize: 15,
                    onTap: () {
                      if (salaryController.text.isEmpty) {
                        setState(() {
                          nameError = true;
                        });
                        errorExists = true;
                      }

                      if (!errorExists) {
                        widget.isEditing ? editIncome() : addIncome();
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
        createdBy: userModel.currentUser.value.id,
        month: DateTime.parse(selectedDate),
        dateCreated: DateTime.now()));
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

  void editIncome() async {
    setState(() {
      isLoading = true;
    });
    var res = await _monthlyIncomeModule
        .updateIncome((widget.incomeModel?.id ?? ''), {
      'salary': salaryController.text,
      'month': selectedDate,
      'extraIncome': _res,
    });

    if (res.status == ResponseType.success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Monthly Income Updated!"),
      ));
      // back
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
  const AddExtraIncome({this.currentExtraIncomes, Key? key}) : super(key: key);
  final List<Map<String, dynamic>>? currentExtraIncomes;

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
    if (widget.currentExtraIncomes != null) {
      asmap.addAll(widget.currentExtraIncomes!);
    }

    asmap.fold<double>(
        0,
        (previousValue, _extraInc) =>
            previousValue +
            (double.tryParse(_extraInc['item']['amount'].toString()) ?? 0));

    double _tt = 0;
    for (var _extraInc in asmap) {
      _tt + (double.tryParse(_extraInc['item']['amount'].toString()) ?? 0);
    }

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
        backgroundColor: const Color.fromRGBO(85, 54, 33, 1),
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
                        : const Center(
                            child: Text('Please Add Incomes'),
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
