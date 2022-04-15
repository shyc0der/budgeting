// ignore_for_file: file_names

import 'package:budget/src/input.dart';
import 'package:budget/src/pages/budgetCategoryPage/addBudgetCategory.dart';
import 'package:budget/src/pages/signUpPage.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController pswdController=TextEditingController();
  bool emailError=false;
  bool pswdError=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: [
          const  SizedBox(height: 150,child: BackgroundPage()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                // Text Login
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('Login',
                  style: 
                  TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.black),
                  ),
                ),
                //text 
               const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5),
                  child:  Text('Please Sign In To Continue',
                  style:
                   TextStyle(fontWeight: FontWeight.normal,fontSize: 16,color: Colors.black87),),
                ),
                const SizedBox(height: 20,),
       inputField('EMAIL', emailController, emailError),
       const SizedBox(height: 10,),
       inputField('Password', pswdController, pswdError),
     const SizedBox(height: 45,),
       
       Align(

             alignment: Alignment.bottomRight,
               child: CustomElavtedButton(
                  errorExists: false,
                 label: 'Login',
                 fontSize: 20,
                 iconData: Icons.arrow_forward,
                 onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddBudgetCategory()));
                },
               ),
       )



            ],),
          ),
       
        ]
        ,
        
      ),
      floatingActionButton: Align(
  alignment: Alignment.bottomCenter,
  child: GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> const SignUpPage()));
    },
    child: RichText(text: const TextSpan( text: 'Do not have an Account ? ',
    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:Colors.black87),
    //DefaultTextStyle.of(context).style,
    children: <TextSpan> [
      TextSpan(text: 'Sign up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 12))
    ]
    
    ),
    
      ),
  ),
)

,
    );
  }
}