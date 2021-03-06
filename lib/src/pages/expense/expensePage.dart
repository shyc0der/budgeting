// ignore_for_file: file_names

import 'package:budget/src/models/expenses.dart';
import 'package:budget/src/models/userModel.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/modules/expenseModule.dart';
import 'package:budget/src/modules/userModule.dart';
import 'package:budget/src/pages/expense/addExpensePage.dart';
import 'package:budget/src/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';

import 'expenseDetailPage.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final ExpenseModule _expenseModule = ExpenseModule();
  final BudgetCategoryModule _budgetCategoryModule = BudgetCategoryModule();
  UserModule userModel = Get.put(UserModule());

  List<Map<String, dynamic>> eExpenses = [
    {
      'item': {'expense': 'shopping', 'amount': 100},
    }
  ];
  @override
  void initState() {
    _budgetCategoryModule.init(userModel.currentUser.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "EXPENSES",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                StreamBuilder<List<ExpenseModel>>(
                    stream: _expenseModule
                        .fetchExpenses(userModel.currentUser.value),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const LinearProgressIndicator();
                        case ConnectionState.none:
                          return const Text('NO DATA');

                        default:
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: (snapshot.data ?? []).length,
                              itemBuilder: (context, index) {
                                eExpenses = snapshot.data![index].expenses!;
                                double _tt = 0;
                                for (var _extraInc in eExpenses) {
                                  _tt = _tt +
                                      (double.tryParse(_extraInc['item']
                                                  ['amount']
                                              .toString()) ??
                                          0);
                                }

                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const LinearProgressIndicator();
                                  case ConnectionState.none:
                                    return const Text('No data');
                                  default:
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ExpenseDetailsPage(
                                                          expenseModel: snapshot
                                                              .data?[index],
                                                          total: _tt,
                                                        )));
                                      },
                                      child: Dismissible(
                                        key: UniqueKey(),
                                        confirmDismiss: (direction) async {
                                          bool? _delete = await dismissWidget(
                                              snapshot.data![index].id!);
                                          if (_delete == true) {
                                            await _expenseModule.deleteExpenses(
                                                snapshot.data![index].id!);

                                                 ScaffoldMessenger.of(context).showSnackBar(
                                                   const SnackBar(
                                                content: Text("Expense Deleted!"),
                                                ));
                                            //print('delete successful');
                                          }
                                          else{

                                                 ScaffoldMessenger.of(context).showSnackBar(
                                                   const SnackBar(
                                                content: Text("Expense Not Deleted!")));
                                          }
                                        },
                                        child: ListTile(
                                          leading: Text(DateFormat("MMMM")
                                              .format(DateTime.parse(snapshot
                                                  .data![index].month
                                                  .toString()))),
                                          trailing: Text(DateTime.parse(snapshot
                                                  .data![index].month
                                                  .toString())
                                              .year
                                              .toString()),
                                          title: Text(
                                              'Total Expenses : Ksh. $_tt'),
                                        ),
                                      ),
                                    );
                                }
                              });
                      }
                    }),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(194, 72, 38, 1),
            child: const Icon(Icons.add),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddExpense(),
                  ),
                )));
  }
}
