
import 'package:budget/src/models/expenses.dart';
import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/pages/expense/addExpensePage.dart';
import 'package:budget/src/pages/monthlyIncomePage/addMonthlyIncome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyIncomeDetails extends StatefulWidget {
  MonthlyIncomeDetails({this.incomeModel, this.total,Key? key}) : super(key: key);
  MonthlyIncomeModel? incomeModel = MonthlyIncomeModel();
  double? total = 0;

  @override
  State<MonthlyIncomeDetails> createState() => _MonthlyIncomeDetailsState();
}

class _MonthlyIncomeDetailsState extends State<MonthlyIncomeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Monthly Income Detail'),
        actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddMonthlyIncome(
                            isEditing: true,
                            incomeModel: widget.incomeModel,
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
                            (widget.incomeModel!.month ?? DateTime.now())
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
                        (widget.incomeModel!.month ?? DateTime.now())
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
                    const Text('Total Income Amount'),
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
                      const Text('INCOMES'),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: widget.incomeModel!.extraIncome?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SingleChildScrollView(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.incomeModel?.extraIncome![index]
                                              ['item']['name'] ??
                                          ''),
                                      Text(
                                          (widget.incomeModel?.extraIncome![index]
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
