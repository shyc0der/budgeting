import 'package:budget/src/input.dart';
import 'package:budget/src/models/budgetCategory.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBudgetCategory extends StatefulWidget {
  AddBudgetCategory({this.budget, this.isEditing = false, Key? key})
      : super(key: key);
  bool isEditing;
  final BudgetCategoryModel? budget;
  @override
  _AddBudgetCategoryState createState() => _AddBudgetCategoryState();
}

class _AddBudgetCategoryState extends State<AddBudgetCategory> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  late String selectedDate = DateTime.now().toString();
  final BudgetCategoryModule _budgetCategoryModule = BudgetCategoryModule();
  bool nameError = false;
  bool amountError = false;
  bool isLoading = false;
  bool errorExists = false;
  List<Map<String, dynamic>>  budgets = [
    {
      'item': {'budget': 'shopping', 'amount': 100},
    }
  ];
  @override
  void initState() {
     budgets.clear();

    if (widget.isEditing) {
      budgets = widget.budget!.budgets!;
      selectedDate = widget.budget!.month!.toString();
    }

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

              const SizedBox(height: 36),
              Text(
                widget.isEditing
                    ? 'EDIT BUDGET CATEGORY'
                    : 'ADD BUDGET CATEGORY',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              //name
              inputField('BUDGET CATEGORY NAME ', nameController, nameError,
                  onChanged: (val) {
                if (val.isNotEmpty) {
                  setState(() {
                    nameError = false;
                  });
                }
              }),
              const SizedBox(
                height: 10,
              ),
              //Amount Budgeted
              inputField(
                'BUDGET AMOUNT ',
                amountController,
                amountError,
                isNumbers: true,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      amountError = false;
                    });
                  }
                },
              ),

              const SizedBox(height: 36),
              // YEAR and MONTH
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  onPressed: () async {
                    if (amountController.text.isEmpty) {
                      setState(() {
                        amountError = true;
                      });
                      errorExists = true;
                    }
                    if (nameController.text.isEmpty) {
                      setState(() {
                        nameError = true;
                      });
                      errorExists = true;
                    }

                    if (!errorExists) {
                      addItemsToList();
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Budgets')),
        
              //Save
              budgets.isNotEmpty
                  ? 
                  Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(3.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text('Budgets'),
                       const SizedBox(
                         height: 5,
                       ),
                       Expanded(
                         child: ListView.builder(
                             itemCount: budgets.length,
                             itemBuilder:
                                 (BuildContext context, int index) {
                               return SingleChildScrollView(
                                 child: Card(
                                   child: Dismissible(
                                     key: UniqueKey(),
                                     onDismissed: (_) async{
                                       
                                       //TODO DELETE BUDGETS
                                               
                                     },
                                     child: Row(
                                       mainAxisAlignment:
                                           MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(
                                           budgets[index]
                                                   ['item']['budget']
                                               .toString(),
                                         ),
                                         Text(budgets[index]
                                                 ['item']['amount']
                                             .toString())
                                       ],
                                     ),
                                   ),
                                 ),
                               );
                             }),
                       ),
                             Expanded(
                               child: Row(
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
               label: widget.isEditing ? 'EDIT BUDGET' : 'ADD BUDGET',
               fontSize: 15,
               onTap: () {
                 if (!errorExists) {
                   widget.isEditing ? updateBudget() : addBudget();
                 }
               },
                  ),
                ),
                                   ],
                                 ),
                             ),
          
                          
                
          ],
                   ),
                 ),
               )
                  : Container()
            ]),
          ),
        ],
      ),
    );
  }

  void addItemsToList() {
    setState(() {
      budgets.add(
        {
          'item': {
            'budget': nameController.text,
            'amount': amountController.text
          }
        },
      );
    });
    amountController.clear();
    nameController.clear();
  }

  void addBudget() async {
    setState(() {
      isLoading = true;
    });

    var res = await _budgetCategoryModule.addBudget(BudgetCategoryModel(
      budgets: budgets,
      dateCreated: DateTime.now(),
      month: DateTime.parse(selectedDate),
      createdBy: 'Steady',
    ));
    if (res.status == ResponseType.success) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Budget Category Added Sucessfully')));
      Navigator.pop(context);
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: res.body.toString(),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  void updateBudget() async {
    setState(() {
      isLoading = true;
    });

    var res =
        await _budgetCategoryModule.updateBudget((widget.budget?.id ?? ''), {
      'budgets': budgets,
      'month': selectedDate,
    });

    if (res.status == ResponseType.success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Budget Category Updated!"),
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
