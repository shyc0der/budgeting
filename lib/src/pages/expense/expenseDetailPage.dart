
import 'package:budget/src/models/expenses.dart';
import 'package:budget/src/pages/expense/addExpensePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseDetailsPage extends StatefulWidget {
  ExpenseDetailsPage({this.expenseModel, this.total,Key? key}) : super(key: key);
  ExpenseModel? expenseModel = ExpenseModel();
  double? total = 0;

  @override
  State<ExpenseDetailsPage> createState() => _ExpenseDetailsPageState();
}

class _ExpenseDetailsPageState extends State<ExpenseDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Expenses Detail'),
        actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddExpense(
                            isEditing: true,
                            expenseModel: widget.expenseModel,
                          )));
                },
                icon: const Icon(Icons.edit)),
        ],
      ),
      
      body: Center(
        child: Container(
          width: 350,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // text
                    const Text('Year'),
                    //text
                    Text(DateTime.parse(
                            (widget.expenseModel!.month ?? DateTime.now())
                                .toString())
                        .year
                        .toString()),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // text
                    const Text('Month'),
                    //text
                    Text(DateFormat("MMMM").format(DateTime.parse(
                        (widget.expenseModel!.month ?? DateTime.now())
                            .toString()))),
                  ],
                ), 
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // text
                    const Text('Total Expense Amount'),
                    //text
                    Text((widget.total ?? 0 ).toString()),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('EXPENSES'),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: widget.expenseModel!.expenses?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SingleChildScrollView(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.expenseModel?.expenses![index]
                                              ['item']['expense'] ??
                                          ''),
                                      Text(
                                          (widget.expenseModel?.expenses![index]
                                                      ['item']['amount'] ??
                                                  0)
                                              .toString()),
                                    ],
                                  ),
                                );
                              })),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
