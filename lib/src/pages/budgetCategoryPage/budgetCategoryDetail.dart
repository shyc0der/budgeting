import 'package:budget/src/models/budgetCategory.dart';
import 'package:budget/src/pages/budgetCategoryPage/addBudgetCategory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BudgetCategoryDetailPage extends StatefulWidget {
  BudgetCategoryDetailPage({this.budgetModel,this.total, Key? key}) : super(key: key);
  BudgetCategoryModel? budgetModel;
  double? total = 0;

  @override
  State<BudgetCategoryDetailPage> createState() =>
      _BudgetCategoryDetailPageState();
}

class _BudgetCategoryDetailPageState extends State<BudgetCategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(85, 54, 33, 1),
        title: const Text(
          'MONTHLY BUDGET DETAIL',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddBudgetCategory(
                            isEditing: true,
                            budget: widget.budgetModel,
                          )));
        }, icon: const Icon(Icons.edit))],
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
                          (widget.budgetModel!.month ?? DateTime.now())
                              .toString())),
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: ' ${DateTime.parse(
                                (widget.budgetModel!.month ?? DateTime.now())
                                    .toString())
                            .year}' ,
                            
                        style:
                            const TextStyle(fontSize: 19, color: Colors.black))
                  ])),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.budgetModel!.budgets!.isEmpty ? const Center(child :Text('No Data')) :
            SfCircularChart(
              legend:
                  Legend(isVisible: true, textStyle: TextStyle(fontSize: 18)),
              title: ChartTitle(
                  text: 'Total Amount : ${widget.total ?? 0}',
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              series: <CircularSeries>[
                PieSeries<Map<String, dynamic>, String>(
                  dataSource: widget.budgetModel?.budgets,
                  xValueMapper: (Map<String, dynamic> maps, _) =>
                      maps['item']['budget'],
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
            
            widget.budgetModel!.budgets!.isEmpty ? const Center(child :Text('No Data')) :
            Expanded(
              child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: widget.budgetModel?.budgets!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: SingleChildScrollView(
                        child: ListTile(
                          title: Text(widget.budgetModel?.budgets?[index]
                              ['item']['budget']),
                          trailing: Text(
                              'KES ${widget.budgetModel?.budgets?[index]['item']['amount']}'),
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
