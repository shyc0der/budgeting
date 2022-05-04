// ignore_for_file: file_names, must_be_immutable

import 'package:budget/src/models/budgetCategory.dart';
import 'package:budget/src/models/userModel.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/modules/userModule.dart';
import 'package:budget/src/pages/budgetCategoryPage/addBudgetCategory.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';

import 'budgetCategoryDetail.dart';

class BudgetCategoryPage extends StatefulWidget {
  BudgetCategoryPage({this.budget, Key? key}) : super(key: key);
  BudgetCategoryModel? budget = BudgetCategoryModel();

  @override
  State<BudgetCategoryPage> createState() => _BudgetCategoryPageState();
}

class _BudgetCategoryPageState extends State<BudgetCategoryPage> {
  final BudgetCategoryModule _budgetCategoryModule = BudgetCategoryModule();
  UserModule userModel = Get.put(UserModule());
  List<Map<String, dynamic>> budgets = [
    {
      'item': {'budget': 'shopping', 'amount': 100},
    }
  ];
  @override
  void initState() {
    _budgetCategoryModule.init(userModel.currentUser.value);
    print(userModel.currentUser.value.asMap());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          //physics:const  NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "MONTLY BUDGETS",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                StreamBuilder<List<BudgetCategoryModel>>(
                    stream: _budgetCategoryModule
                        .fetchBudgets(userModel.currentUser.value),
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
                                budgets = snapshot.data![index].budgets!;
                                double _tt = 0;
                                for (var budget in budgets) {
                                  _tt = _tt +
                                      (double.tryParse(budget['item']['amount']
                                              .toString()) ??
                                          0);
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BudgetCategoryDetailPage(
                                                    budgetModel:
                                                        snapshot.data?[index],
                                                    total: _tt)));
                                  },
                                  child: ListTile(
                                    //DateTime.parse(snapshot.data![index].month.toString()).month.toString()
                                    leading: Text(DateFormat("MMMM").format(
                                        DateTime.parse(snapshot
                                            .data![index].month
                                            .toString()))),
                                    title: Text('Total Budget : Ksh. $_tt'),
                                    trailing: Text(DateTime.parse(snapshot
                                            .data![index].month
                                            .toString())
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
            backgroundColor: const Color.fromRGBO(194, 72, 38, 1),
            child: const Icon(Icons.add),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBudgetCategory(),
                  ),
                )));
  }
}
