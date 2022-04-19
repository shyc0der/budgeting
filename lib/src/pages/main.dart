import 'package:budget/src/pages/budgetCategoryPage/budgetCategoryPage.dart';
import 'package:budget/src/pages/expense/expensePage.dart';
import 'package:budget/src/pages/monthlyIncomePage/monthlyIncomePage.dart';
import 'package:flutter/material.dart';


import 'background_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackgroundPage(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
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
                height: 40,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,bottom: 10),
                  child: Wrap(
                    spacing: 20.0,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BudgetCategoryPage()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/budget.png',
                                width: 100,
                              ),
                              const Text(
                                'BUDGET',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                        height: 40,
                      ),
                      Padding(                       
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ExpensesPage()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/budget.png',
                                width: 100,
                              ),
                              const Text(
                                'EXPENSES',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20, height: 40),
                      Padding(                        
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const  MonthlyIncomePage()));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/budget.png',
                                width: 100,
                              ),
                              const Text(
                                'INCOMES',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
