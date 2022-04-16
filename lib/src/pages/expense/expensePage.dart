import 'package:budget/src/models/expenses.dart';
import 'package:budget/src/modules/expenseModule.dart';
import 'package:budget/src/pages/expense/addExpensePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final ExpenseModule _expenseModule = ExpenseModule();
  List<Map<String, dynamic>> eExpenses = [
    {
      'item': {'expense': 'shopping', 'amount': 100},
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text('Expenses'),
        ),
        body: SingleChildScrollView(
          //physics:const  NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<List<ExpenseModel>>(
                    stream: _expenseModule.fetchExpenses(),
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
                               print( snapshot.data![index].expenses?[0]['item']['expense']);
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
                                                builder: (BuildContext
                                                        context) =>
                                                    AddExpense(
                                                        isEditing: true,
                                                        expenseModel: snapshot
                                                            .data?[index])));
                                      },
                                      child: ListTile(
                                        leading: Text(DateFormat("MMMM").format(
                                            DateTime.parse(snapshot
                                                .data![index].month
                                                .toString()))),
                                       
                                        trailing: Text(DateTime.parse(snapshot
                                                .data![index].month
                                                .toString())
                                            .year
                                            .toString()),
                                        title : Text('Total Expenses : Ksh. $_tt'),
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
            backgroundColor: Colors.orange[600],
            child: const Icon(Icons.add),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddExpense(),
                  ),
                )));
  }
}
