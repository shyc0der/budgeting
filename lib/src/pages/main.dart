import 'package:budget/src/models/userModel.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/modules/firebaseUserModule.dart';
import 'package:budget/src/modules/userModule.dart';
import 'package:budget/src/pages/budgetCategoryPage/budgetCategoryPage.dart';
import 'package:budget/src/pages/expense/expensePage.dart';
import 'package:budget/src/pages/loginPage.dart';
import 'package:budget/src/pages/monthlyIncomePage/monthlyIncomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({this.userid, Key? key}) : super(key: key);
  final String? userid;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int selectedIndex = 0;
  final UserModule userModule = Get.find<UserModule>();
  final BudgetCategoryModule _budgetCategoryModule =
      Get.put(BudgetCategoryModule());

  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex: 0, length: 3, vsync: this);
    setState(() {
      _budgetCategoryModule.init(userModule.currentUser.value);
    });
  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(194, 72, 38, 1),
            title: const Text('Budget App'),
            actions: [
              IconButton(
                  onPressed: () async {
                    FirebaseUser.logout();
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  icon: const Icon(Icons.logout))
            ],
            bottom: TabBar(controller: _controller,
                //padding: EdgeInsets.all(19),
                tabs: [
                  Tab(
                    icon: Image.asset(
                      'assets/images/budget.png',
                      height: 43,
                    ),
                    text: 'BUDGET',
                  ),
                  Tab(
                    icon: Image.asset(
                      'assets/images/expense.png',
                      height: 43,
                    ),
                    text: 'EXPENSES',
                  ),
                  Tab(
                    icon: Image.asset(
                      'assets/images/revenue.png',
                      height: 43,
                    ),
                    text: 'INCOMES',
                  ),
                ])),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            //BUDGET

            BudgetCategoryPage(),
            const ExpensesPage(),
            const MonthlyIncomePage()
          ],
        ),
      ),
    );
  }
}
