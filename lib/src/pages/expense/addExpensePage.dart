// ignore_for_file: must_be_immutable, file_names

import 'package:budget/src/input.dart';
import 'package:budget/src/models/expenses.dart';
import 'package:budget/src/modules/expenseModule.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../background_page.dart';

class AddExpense extends StatefulWidget {
  AddExpense({this.expenseModel, this.isEditing = false, Key? key})
      : super(key: key);
  bool isEditing;
  ExpenseModel? expenseModel;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
 final ExpenseModule _expenseModule = ExpenseModule();
  late String selectedDate = DateTime.now().toString();
  TextEditingController expenseTypeController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  bool isExpenseType = false;
  bool isAmount = false;
  bool errorExists = false;
  bool isLoading = false;

  List<Map<String, dynamic>> expenseTypesAmount = [
    {
      'item': {'expense': 'shopping', 'amount': 100},
    }
  ];
  @override
  void initState() {
    expenseTypesAmount.clear();
    if (widget.isEditing) {
      selectedDate = (widget.expenseModel?.month ?? DateTime.now()).toString();
      expenseTypesAmount = widget.expenseModel!.expenses!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
        body: Stack(
      children: [
        const BackgroundPage(),
        Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 30,
              ),
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
                height: 50,
              ),
              //Text
              Text(
                widget.isEditing ? 'EDIT EXPENSE' : 'ADD EXPENSE',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              //Date
              DateTimePicker(
                decoration:const  InputDecoration(fillColor: Color.fromRGBO(85, 54, 33, 1),),
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

              //expense type
              inputField('Expense Type', expenseTypeController, isExpenseType,
                  onChanged: (val) {
                if (val.isEmpty) {
                  setState(() {
                    isExpenseType = true;
                  });
                }
              }),
              //amount
              inputField(
                'Amount',
                expenseAmountController,
                isAmount,
                isNumbers: true,
                onChanged: (val) {
                  if (val.isEmpty) {
                    setState(() {
                      isAmount = true;
                    });
                  }
                },
              ),

            const  SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(85, 54, 33, 1),
                  ),
                  onPressed: () async {
                    if (expenseAmountController.text.isEmpty) {
                      setState(() {
                        isAmount = true;
                      });
                      errorExists = true;
                    }
                    if (expenseTypeController.text.isEmpty) {
                      setState(() {
                        isExpenseType = true;
                      });
                      errorExists = true;
                    }

                    if (!errorExists) {
                      addItemsToList();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Expenses')),

              const SizedBox(
                height: 12,
              ),
              //list view builder

              expenseTypesAmount.isNotEmpty
                  ? 
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Expenses'),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: expenseTypesAmount.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SingleChildScrollView(
                                      child: Card(
                                        child: Dismissible(
                                          key: UniqueKey(),
                                          onDismissed: (_) async{
                                            
                                            await _expenseModule
                                                .deleteExpenseExpenses(
                                                    (widget.expenseModel!.id!),
                                                    index.toString());
                                                    
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                expenseTypesAmount[index]
                                                        ['item']['expense']
                                                    .toString(),
                                              ),
                                              Text(expenseTypesAmount[index]
                                                      ['item']['amount']
                                                  .toString())
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: CustomElavtedButton(
                                errorExists: errorExists,
                                label: 'Save Expenses',
                                fontSize: 15,
                                onTap: () {
                                  widget.isEditing
                                      ? editExpenses()
                                      : addExpenses();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container()
            ])),
      ],
    ));
  }

  void addExpenses() async {
    setState(() {
      isLoading = true;
    });
    var res = await _expenseModule.addExpenses(ExpenseModel(
        expenses: expenseTypesAmount,
        month: DateTime.tryParse(selectedDate),
        createdBy: 'Steady',
        dateCreated: DateTime.now()));

    if (res.status == ResponseType.success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Expenses Added Sucessfully')));
      Navigator.pop(context);
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: res.body.toString(),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  void editExpenses() async {
    setState(() {
      isLoading = true;
    });
    var res =
        await _expenseModule.updateExpenses((widget.expenseModel!.id ?? ''), {
      'expenses': expenseTypesAmount,
      'month': selectedDate,
    });

    if (res.status == ResponseType.success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Expenses Added Sucessfully')));
      Navigator.pop(context);
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: res.body.toString(),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  void addItemsToList() {
    setState(() {
      expenseTypesAmount.add(
        {
          'item': {
            'expense': expenseTypeController.text,
            'amount': expenseAmountController.text
          }
        },
      );
    });
    expenseAmountController.clear();
    expenseTypeController.clear();
  }
}
