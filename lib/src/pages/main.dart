import 'package:budget/src/pages/budgetCategoryPage/budgetCategoryPage.dart';
import 'package:budget/src/pages/expense/expensePage.dart';
import 'package:budget/src/pages/monthlyIncomePage/monthlyIncomePage.dart';
import 'package:flutter/material.dart';



class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with SingleTickerProviderStateMixin {
  late TabController  _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    _controller = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
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
            bottom: TabBar
            (controller: _controller,
            //padding: EdgeInsets.all(19),
               tabs: [
              Tab(  
                             
                icon: Image.asset('assets/images/budget.png',height: 43,),  
                text: 'BUDGET',           
                
                
              ),
              Tab(
                icon: Image.asset('assets/images/expense.png',height: 43,),
               text: 'EXPENSES',
              ),
              Tab(
                icon: Image.asset('assets/images/revenue.png',height: 43,),
                text: 'INCOMES',
              ),
            ])),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            //BUDGET
            
            BudgetCategoryPage(),
           const ExpensesPage(),
          const  MonthlyIncomePage()
            
          ],
        ),
      ),
    );
  }
}
