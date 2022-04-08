// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:budget/src/models/budgetCategory.dart';
import 'package:budget/src/modules/budgetCategoryModule.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:budget/src/pages/budgetCategoryPage/addBudgetCategory.dart';
import 'package:flutter/material.dart';

class BudgetCategoryDetails extends StatefulWidget {
  const BudgetCategoryDetails({ Key? key }) : super(key: key);

  @override
  _BudgetCategoryDetailsState createState() => _BudgetCategoryDetailsState();
}

class _BudgetCategoryDetailsState extends State<BudgetCategoryDetails> {
  BudgetCategoryModel _budgetCategoryModel=BudgetCategoryModel();
  BudgetCategoryModule _budgetCategoryModule=BudgetCategoryModule();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //physics: const NeverScrollableScrollPhysics(),
        child:  Stack(          
          children: [
            BackgroundPage(),
            SizedBox(height: 20,),
             Column(   
               crossAxisAlignment: CrossAxisAlignment.start, 

              children: [
                
            SizedBox(height: 70,),
                
                IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back)  ),
                SizedBox(height: 30,),
                StreamBuilder<List<BudgetCategoryModel>>(
                  stream: _budgetCategoryModule.fetchBudgets() ,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting :
                      return LinearProgressIndicator();
                      case ConnectionState.none :
                      return Text('NO DATA');
                        
                      default:
                    
                    return ListView.builder(    
                      
                      shrinkWrap: true,
                      itemCount: (snapshot.data ?? []).length,
                      itemBuilder:(context,index){ 
                        switch (snapshot.connectionState) {
                          case  ConnectionState.waiting :
                          return LinearProgressIndicator();
                          case ConnectionState.none:
                          return Text('No data');                    
                          default:
                              
                      return
                      ListTile(
                        title: Text(snapshot.data![index].name ?? '',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),),
                        subtitle: Text(snapshot.data![index].dateCreated.toString(),style: TextStyle(fontSize: 16)),
                        trailing: Text('Ksh. ${snapshot.data![index].amountBudgeted ?? ''}',style: TextStyle(fontSize: 16,
                        color: Colors.black
                        )),

                      
                      );                                         
                      
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
      child: Icon(Icons.add),
      onPressed: () => 
      Navigator.push(context,MaterialPageRoute(builder: (context) => AddBudgetCategory(),
      ),
      ))
    );
  }
}