import 'package:budget/src/pages/budgetCategoryPage/budgetCategoryPage.dart';
import 'package:budget/src/pages/expense/expensePage.dart';
import 'package:budget/src/pages/monthlyIncomePage/monthlyIncomePage.dart';
import 'package:budget/src/shared.dart';
import 'package:flutter/material.dart';

import 'background_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  PageController _controller = PageController(initialPage: 0);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('BUDGET APP'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: PageView(
                  controller: _controller,
                            children: [
                    //BUDGET
                    ImageText(
                      "BUDGET",
                      'assets/images/budget.png',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BudgetCategoryPage()));
                      },
                    ),
                    ImageText("EXPENSES", 'assets/images/expense.png',
                        onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExpensesPage()));
                    }),
                    ImageText("INCOMES", 'assets/images/revenue.png',
                        onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MonthlyIncomePage()));
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
