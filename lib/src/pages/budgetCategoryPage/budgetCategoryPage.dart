import 'package:budget/src/models/budgetCategory.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/pages/budgetCategoryPage/addBudgetCategory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetCategoryPage extends StatefulWidget {
  BudgetCategoryPage({this.budget, Key? key}) : super(key: key);
  BudgetCategoryModel? budget = BudgetCategoryModel();

  @override
  State<BudgetCategoryPage> createState() => _BudgetCategoryPageState();
}

class _BudgetCategoryPageState extends State<BudgetCategoryPage> {
  final BudgetCategoryModule _budgetCategoryModule = BudgetCategoryModule();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('Budgets'),
      ),
        body: SingleChildScrollView(
          //physics:const  NeverScrollableScrollPhysics(),
          child: Padding(
            
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<List<BudgetCategoryModel>>(
                    stream: _budgetCategoryModule.fetchBudgets(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const LinearProgressIndicator();
                        case ConnectionState.none:
                          return const Text('No data');
                        default:
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: (snapshot.data ?? []).length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                                      
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddBudgetCategory(
                                            isEditing: true,
                                            budget: snapshot.data?[index],
                                          )));
                            },
                                  child: ListTile(
                                    title: Text(snapshot.data![index].name ?? ''),
                                    //DateTime.parse(snapshot.data![index].month.toString()).month.toString()
                                    leading: Text(DateFormat("MMMM").format(
                                        DateTime.parse(snapshot.data![index].month
                                            .toString()))),
                                    subtitle: Text(
                                        'Ksh. ${snapshot.data![index].amountBudgeted ?? ''}'),
                                    trailing: Text(DateTime.parse(
                                            snapshot.data![index].month.toString())
                                        .year
                                        .toString()),
                                  ),
                                );
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
                    builder: (context) => AddBudgetCategory(),
                  ),
                )));
  }
}
