// ignore_for_file: file_names, must_be_immutable
import 'package:budget/src/models/expenses.dart';
import 'package:budget/src/pages/expense/addExpensePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(85, 54, 33, 1),
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
                          (widget.expenseModel!.month ?? DateTime.now())
                              .toString())),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: ' ${DateTime.parse(
                                (widget.expenseModel!.month ?? DateTime.now())
                                    .toString())
                            .year}' ,
                            
                        style:
                            const TextStyle(fontSize: 19, color: Colors.black))
                  ])),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.expenseModel!.expenses!.isEmpty ? const Center(child :Text('No Data')) :
            SfCircularChart(
              legend:
                  Legend(isVisible: true, textStyle: const TextStyle(fontSize: 18)),
              title: ChartTitle(
                  text: 'Total Amount : ${widget.total ?? 0}',
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              series: <CircularSeries>[
                PieSeries<Map<String, dynamic>, String>(
                  dataSource: widget.expenseModel?.expenses,
                  xValueMapper: (Map<String, dynamic> maps, _) =>
                      maps['item']['expense'],
                  yValueMapper: (Map<String, dynamic> maps, _) =>
                     double.tryParse( maps['item']['amount']),
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true, textStyle: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            const Text(
              'Summary',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            
            widget.expenseModel!.expenses!.isEmpty ? const Center(child :Text('No Data')) :
            Expanded(
              child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: widget.expenseModel?.expenses!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: SingleChildScrollView(
                        child: ListTile(
                          title: Text(widget.expenseModel?.expenses?[index]
                              ['item']['expense']),
                          trailing: Text(
                              'KES ${widget.expenseModel?.expenses?[index]['item']['amount']}'),
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



