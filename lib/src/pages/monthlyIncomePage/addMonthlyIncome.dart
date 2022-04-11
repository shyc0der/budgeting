// ignore_for_file: file_names

import 'package:budget/src/input.dart';
import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/modules/monthlyIncome.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMonthlyIncome extends StatefulWidget {
  const AddMonthlyIncome({Key? key}) : super(key: key);

  @override
  _AddMonthlyIncomeState createState() => _AddMonthlyIncomeState();
}

class _AddMonthlyIncomeState extends State<AddMonthlyIncome> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController extraIncomeController = TextEditingController();
  final MonthlyIncomeModule _monthlyIncomeModule = MonthlyIncomeModule();

  bool nameError = false;
  bool amountError = false;
  bool isLoading = false;
  bool errorExists = false;
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
              //Amount Budgeted
              inputField(
                'EXTRA INCOME ',
                extraIncomeController,
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
                    label: 'ADD BUDGET',
                    fontSize: 15,
                    onTap: () {
                      if (salaryController.text.isEmpty) {
                        setState(() {
                          nameError = true;
                        });
                        errorExists = true;
                      }
                      if (extraIncomeController.text.isEmpty) {
                        setState(() {
                          amountError = true;
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
        extraIncome: extraIncomeController.text,
        createdBy: 'Steady',
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
}
