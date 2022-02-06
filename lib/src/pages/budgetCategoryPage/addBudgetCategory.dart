import 'package:budget/src/input.dart';
import 'package:flutter/material.dart';

class AddBudgetCategory extends StatefulWidget {
  const AddBudgetCategory({ Key? key }) : super(key: key);

  @override
  _AddBudgetCategoryState createState() => _AddBudgetCategoryState();
}

class _AddBudgetCategoryState extends State<AddBudgetCategory> {
  TextEditingController nameController=TextEditingController();
  TextEditingController amountController=TextEditingController();
  bool nameError=false;
  bool amountError=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[  
            const SizedBox(height: 20,),  
            //icon
          IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const  Icon(Icons.arrow_back,color: Colors.black87, size: 27,)),
       
           const SizedBox(height: 20,),           
            //Text
            const Text('ADD BUDGET CATEGORY',         
             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black),),                
           const SizedBox(height: 20,),        
          //name
          inputField('BUDGET CATEGORY NAME ', nameController, nameError),
           const SizedBox(height: 10,), 
          //Amount Budgeted
          inputField('BUDGET AMOUNT ', amountController, amountError,isNumbers: true),   
          const  SizedBox(height:36),
         //Save
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children:[
             elevatedButton('CANCEL',125,Alignment.bottomLeft,15),
         elevatedButton('ADD BUDGET',165,Alignment.bottomRight,15), 
          
           ]
         )
         
          ]
        ),
      ),
      
    );
  }
}