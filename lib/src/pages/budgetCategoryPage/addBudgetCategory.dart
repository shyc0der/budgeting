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
  @override
  void initState() {
    if (widget.isEditing) {
      nameController.text = widget.budget?.name ?? '';
      amountController.text = widget.budget?.amountBudgeted ?? '';
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
              DateTimePicker(
                initialValue: selectedDate.toString(),
                firstDate: DateTime(2022),
                lastDate: DateTime(2122),
                dateLabelText: 'Date',
                onChanged: (value) {
                  setState(() {
                    selectedDate =value;
                  });
                },
                initialDatePickerMode: DatePickerMode.year,
              ),

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
                    label: widget.isEditing ? 'EDIT BUDGET' : 'ADD BUDGET',
                    fontSize: 15,
                    onTap: () {
                      if (nameController.text.isEmpty) {
                        setState(() {
                          nameError = true;
                        });
                        errorExists = true;
                      }
                      if (amountController.text.isEmpty) {
                        setState(() {
                          amountError = true;
                        });
                        errorExists = true;
                      }
                      if (!errorExists) {
                        widget.isEditing ? updateBudget() : addBudget();
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

  void addBudget() async {
    setState(() {
      isLoading = true;
    });

    var res = await _budgetCategoryModule.addBudget(BudgetCategoryModel(
      amountBudgeted: amountController.text,
      name: nameController.text,
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
      'amountBudgeted': amountController.text,
      'name': nameController.text,
      'month': selectedDate,
    });

    if (res.status == ResponseType.success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Budget Category Updated!"),
      ));
      // back
      Navigator.pop(context);
    } 
    else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: res.body.toString(),
        backgroundColor: Colors.redAccent,
      ));
    }
  }
}
