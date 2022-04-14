// ignore_for_file: file_names

import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/modules/monthlyIncome.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:budget/src/pages/monthlyIncomePage/addMonthlyIncome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyIncomeDetails extends StatefulWidget {
  const MonthlyIncomeDetails({Key? key}) : super(key: key);

  @override
  _MonthlyIncomeDetailsState createState() => _MonthlyIncomeDetailsState();
}

class _MonthlyIncomeDetailsState extends State<MonthlyIncomeDetails> {
  final MonthlyIncomeModule _monthlyIncomeModule = MonthlyIncomeModule();
  List<Map<String, dynamic>> extraIncome = [
    {
      'item': {'name': 'shopping', 'amount': 100},
    }
  ];
  //double _tt = 0;
  @override
  void initState() {
    extraIncome.clear();

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
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text('MONTHLY INCOMES'),
        ),
        body: SingleChildScrollView(
          //physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<List<MonthlyIncomeModel>>(
                  stream: _monthlyIncomeModule.fetchIncome(),
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
                              extraIncome = snapshot.data![index].extraIncome!;
                              double _tt = 0;
                              for (var _extraInc in extraIncome) {
                                _tt=_tt +
                                    (double.tryParse(_extraInc['item']['amount']
                                            .toString()) ??
                                        0);

                              }


                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const LinearProgressIndicator();
                                case ConnectionState.none:
                                  return const Text('No data');
                                default:
                                  return ListTile(
                                    leading: Text(DateFormat("MMMM").format(
                                        DateTime.parse(snapshot
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
                                  );
                              }
                            });
                    }
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange[600],
            child: const Icon(Icons.add),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMonthlyIncome(),
                  ),
                )));
  }
}
