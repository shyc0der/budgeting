import 'package:budget/src/models/budgetCategory.dart';
import 'package:budget/src/models/model.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/modules/firebaseUserModule.dart';
import 'package:budget/src/modules/userModule.dart';
import 'package:budget/src/pages/budgetCategoryPage/budgetCategoryPage.dart';
import 'package:budget/src/pages/expense/expenseDetailPage.dart';
import 'package:budget/src/pages/expense/expensePage.dart';
import 'package:budget/src/pages/loginPage.dart';
import 'package:budget/src/pages/main.dart';
import 'package:budget/src/pages/monthlyIncomePage/monthlyIncomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Model.initiateFireStore();
  Get.put(BudgetCategoryModule());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final UserModule userModule = Get.put(UserModule());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseUser.userLoginState(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const MaterialApp(
                  home: Material(
                      child: Center(child: LinearProgressIndicator())));
            case ConnectionState.none:
              return const MaterialApp(
                  home: Material(child:  Text('no connection')));
            default:

              return FutureBuilder(
                future: userModule.setCurrentUser((snapshot.data?.uid).toString()),
                builder: (_, __){
                  return GetMaterialApp(
              title: 'BudgetApp',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
              initialRoute: snapshot.data == null ? '/login' : '/',
              
              onGenerateRoute: (settings){
                // check if logged in
                if(snapshot.data == null){ // send to login page
                  return MaterialPageRoute(builder: (context)=> LoginPage(), settings: RouteSettings(name: '/login'));
                }
                switch (settings.name) {
                  case '/':
                    return MaterialPageRoute(builder: (context)=> FirstPage(), settings: RouteSettings(name: '/'));
                   case '/budgets':
                    return MaterialPageRoute(builder: (context)=> BudgetCategoryPage(), settings: RouteSettings(name: '/budgets'));
                  case '/expenses':
                    return MaterialPageRoute(builder: (context)=> ExpensesPage(), settings: RouteSettings(name: '/expenses'));
                  case '/income':
                                       
                    return MaterialPageRoute(builder: (context)=> MonthlyIncomePage(),settings: RouteSettings(name: '/incomes'));
                     
                  case '/login':
                      // check if logged in
                    return MaterialPageRoute(builder: (context)=> LoginPage(), settings: RouteSettings(name: '/login'));
                  default:
                  return MaterialPageRoute(builder: (context)=> LoginPage(), settings: RouteSettings(name: '/'));
                }
              },
            );
                },
              );
          }
        });
  }
}
