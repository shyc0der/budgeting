
// ignore_for_file: avoid_unnecessary_containers

import 'package:budget/src/input.dart';
import 'package:budget/src/pages/signUpPage.dart';
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [
          const  SizedBox(height: 150,),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                // Text Login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    child: const Text('Login',
                    style: 
                    TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.black),
                    ),
                    
                  ),
                ),
                //text 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(child: const Text('Please Sign In To Continue',
                  style:
                   TextStyle(fontWeight: FontWeight.normal,fontSize: 16,color: Colors.black87),),),
                ),
                const SizedBox(height: 20,),
       inputField('EMAIL', emailController, emailError),
       const SizedBox(height: 10,),
       inputField('Password', pswdController, pswdError),
     const SizedBox(height: 45,),
       
       Align(
             alignment: Alignment.bottomRight,
               child: Container(
                 
               width: 115,
               height: 40,
               decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),               
               ),
               color: Colors.orange
               ),
               margin: const EdgeInsets.symmetric(horizontal: 3), 
               child: ElevatedButton(onPressed: (){},
               style: ElevatedButton.styleFrom(
                 primary: Colors.orange,
                 
               ),
                child: 
               Container(
                 child: Row( 
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children:const [
                          Text('Login',style:TextStyle(fontWeight: FontWeight.normal,fontSize: 18)),
                          Icon(Icons.arrow_forward),
                          
                          ]),
               )),
             ),
       )



            ],),
         
          ]
          ,
          
        ),
      ),
      floatingActionButton: Align(
  alignment: Alignment.bottomCenter,
  child: Container(child: GestureDetector(
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
  )
  
  ,),
)

,
    );
  }
}