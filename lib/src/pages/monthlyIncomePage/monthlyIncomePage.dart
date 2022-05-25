// ignore_for_file: file_names

import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/modules/monthlyIncome.dart';
import 'package:budget/src/modules/userModule.dart';
import 'package:budget/src/pages/monthlyIncomePage/addMonthlyIncome.dart';
import 'package:budget/src/pages/monthlyIncomePage/monthlyIncomeDetails.dart';
import 'package:budget/src/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';

class MonthlyIncomePage extends StatefulWidget {
  const MonthlyIncomePage({Key? key}) : super(key: key);

  @override
  _MonthlyIncomePageState createState() => _MonthlyIncomePageState();
}

class _MonthlyIncomePageState extends State<MonthlyIncomePage> {
  final MonthlyIncomeModule _monthlyIncomeModule = MonthlyIncomeModule();
  UserModule userModel = Get.put(UserModule());

  final BudgetCategoryModule _budgetCategoryModule = BudgetCategoryModule();

  List<Map<String, dynamic>> extraIncome = [
    {
      'item': {'name': 'shopping', 'amount': 100},
    }
  ];
  //double _tt = 0;
  @override
  void initState() {
    extraIncome.clear();
    _budgetCategoryModule.init(userModel.currentUser.value);

    super.initState();
  }

  double get amount {
    // var _res = extraIncome.fold<double>(
    //     0,
    //     (previousValue, _extraInc) =>
    //         previousValue +
    //         (double.tryParse(_extraInc['item']['amount'].toString()) ?? 0));

    double _tt = 0;
    for (var _extraInc in extraIncome) {
      _tt + (double.tryParse(_extraInc['item']['amount'].toString()) ?? 0);
    }
    return _tt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          //physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "MONTHLY INCOME",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                StreamBuilder<List<MonthlyIncomeModel>>(
                    stream: _monthlyIncomeModule
                        .fetchIncome(userModel.currentUser.value),
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
                                extraIncome =
                                    snapshot.data![index].extraIncome!;
                                double _tt = 0;
                                for (var _extraInc in extraIncome) {
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
                                                        MonthlyIncomeDetails(
                                                          incomeModel: snapshot
                                                              .data?[index],
                                                          total: _tt,
                                                        )));
                                      },
                                      child: Dismissible(
                                        key: UniqueKey(),
                                        confirmDismiss: (direction) async {
                                          bool? _delete = await dismissWidget(
                                              '${DateFormat("MMMM").format(
                                              DateTime.parse(snapshot
                                                  .data![index].month
                                                  .toString()))} Income');
                                          if (_delete == true) {
                                            await _monthlyIncomeModule
                                                .deleteIncome(
                                                    snapshot.data![index].id);

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                   const SnackBar(
                                                content: Text("Income Deleted!")));
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                   const SnackBar(
                                                content: Text("Income Not Deleted!")));
                                          }
                                        },
                                        child: ListTile(
                                          leading: Text(DateFormat("MMMM")
                                              .format(DateTime.parse(snapshot
                                                  .data![index].month
                                                  .toString()))),
                                          subtitle: Text(
                                              'Main Income : Ksh. ${snapshot.data![index].salary ?? ''}'),
                                          trailing: Text(DateTime.parse(snapshot
                                                  .data![index].month
                                                  .toString())
                                              .year
                                              .toString()),
                                          title: Text(
                                              'Total Income : Ksh. ${(double.tryParse(snapshot.data![index].salary.toString()) ?? 0) + _tt}'),
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
                    builder: (context) => const AddMonthlyIncome(),
                  ),
                )));
  }
}
