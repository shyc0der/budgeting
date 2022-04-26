import 'package:budget/src/models/expenses.dart';
import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/pages/expense/addExpensePage.dart';
import 'package:budget/src/pages/monthlyIncomePage/addMonthlyIncome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyIncomeDetails extends StatefulWidget {
  MonthlyIncomeDetails({this.incomeModel, this.total, Key? key})
      : super(key: key);
  MonthlyIncomeModel? incomeModel = MonthlyIncomeModel();
  double? total = 0;

  @override
  State<MonthlyIncomeDetails> createState() => _MonthlyIncomeDetailsState();
}

class _MonthlyIncomeDetailsState extends State<MonthlyIncomeDetails> {
  @override
  Widget build(BuildContext context) {
    widget.incomeModel!.extraIncome!.add(
      {
        'item': {'name': 'Salary', 'amount': widget.incomeModel!.salary}
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(85, 54, 33, 1),
        title: const Text('Monthly Income Detail'),
        actions: [
          IconButton(
              onPressed: () {
                widget.incomeModel!.extraIncome!.removeLast(
                  
                );
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddMonthlyIncome(
                          isEditing: true,
                          incomeModel: widget.incomeModel,
                        )));
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 35,
              child: RichText(
                  text: TextSpan(
                      text: DateFormat("MMMM").format(DateTime.parse(
                          (widget.incomeModel!.month ?? DateTime.now())
                              .toString())),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text:
                            ' ${DateTime.parse((widget.incomeModel!.month ?? DateTime.now()).toString()).year}',
                        style:
                            const TextStyle(fontSize: 19, color: Colors.black))
                  ])),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.incomeModel!.extraIncome!.isEmpty
                ? const Center(child: Text('No Data'))
                : SfCircularChart(
                    legend: Legend(
                        isVisible: true, textStyle: TextStyle(fontSize: 18)),
                    title: ChartTitle(
                        text:
                            'Total Amount : ${((widget.total ?? 0) + (double.tryParse(widget.incomeModel!.salary!) ?? 0))}',
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    series: <CircularSeries>[
                      PieSeries<Map<String, dynamic>, String>(
                        dataSource: widget.incomeModel?.extraIncome,
                        xValueMapper: (Map<String, dynamic> maps, _) =>
                            maps['item']['name'],
                        yValueMapper: (Map<String, dynamic> maps, _) =>
                            double.tryParse(maps['item']['amount']),
                        dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
            const Text(
              'Summary',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            widget.incomeModel!.extraIncome!.isEmpty
                ? const Center(child: Text('No Data'))
                : Expanded(
                    child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: widget.incomeModel?.extraIncome!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: SingleChildScrollView(
                              child: ListTile(
                                title: Text(widget.incomeModel
                                    ?.extraIncome?[index]['item']['name']),
                                trailing: Text(
                                    'KES ${widget.incomeModel?.extraIncome?[index]['item']['amount']}'),
                              ),
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
