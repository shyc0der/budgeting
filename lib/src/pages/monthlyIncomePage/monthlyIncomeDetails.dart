// ignore_for_file: file_names

import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/modules/monthlyIncome.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:budget/src/pages/monthlyIncomePage/addMonthlyIncome.dart';
import 'package:flutter/material.dart';

class BudgetCategoryDetails extends StatefulWidget {
  const BudgetCategoryDetails({ Key? key }) : super(key: key);

  @override
  _BudgetCategoryDetailsState createState() => _BudgetCategoryDetailsState();
}

class _BudgetCategoryDetailsState extends State<BudgetCategoryDetails> {
 final MonthlyIncomeModule _monthlyIncomeModule=MonthlyIncomeModule();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //physics: const NeverScrollableScrollPhysics(),
        child:  Stack(          
          children: [
          const  BackgroundPage(),
          const  SizedBox(height: 20,),
             Column(   
               crossAxisAlignment: CrossAxisAlignment.start, 

              children: [
                
           const SizedBox(height: 70,),
                
                IconButton(onPressed: (){},
                 icon:const Icon(Icons.arrow_back)  ),
               const SizedBox(height: 30,),
                StreamBuilder<List<MonthlyIncomeModel>>(
                  stream: _monthlyIncomeModule.fetchIncome() ,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting :
                      return const LinearProgressIndicator();
                      case ConnectionState.none :
                      return const Text('NO DATA');
                        
                      default:
                    
                    return ListView.builder(    
                      
                      shrinkWrap: true,
                      itemCount: (snapshot.data ?? []).length,
                      itemBuilder:(context,index){ 
                        switch (snapshot.connectionState) {
                          case  ConnectionState.waiting :
                          return const LinearProgressIndicator();
                          case ConnectionState.none:
                          return const Text('No data');                    
                          default:
                              
                      return Container();
                      
                      }} );
                           }         }
                ),
              ],
            ),
          ],
        ),
        
      ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.orange[600],
      child: const Icon(Icons.add),
      onPressed: () => 
      Navigator.push(context,MaterialPageRoute(builder: (context) => const AddMonthlyIncome(),
      ),
      ))
    );
  }
}