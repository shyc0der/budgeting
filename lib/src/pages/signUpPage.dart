// ignore_for_file: avoid_unnecessary_containers

import 'package:budget/src/input.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:budget/src/pages/loginPage.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController pswdController=TextEditingController();
  TextEditingController phoneNoController=TextEditingController();
  bool fullNameError=false;
  bool emailError=false;
  bool pswdError=false;
  bool phoneNoError=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPage(),
          Padding(padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
            const  SizedBox(height: 28,),
            IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: const  Icon(Icons.arrow_back,color: Colors.black87, size: 27,)),
            const  SizedBox(height: 68,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                Container(child: const
                 Text('Create Account',
                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.black)
                 ,)
                 ,),
               const SizedBox(height: 10,),
               inputField('FULL NAME', fullNameController, fullNameError),
               inputField('EMAIL', emailController, emailError),
               inputField('PASSWORD', pswdController, pswdError),
               inputField('PHONE NUMBER', phoneNoController, phoneNoError),

              const SizedBox(height: 35,),
               //sign up button

                 Align(
                 alignment: Alignment.bottomRight,
                   child: CustomElavtedButton(
                     errorExists: false,
                     label: 'SIGN UP',
                     fontSize: 18,
                     iconData: Icons.arrow_forward,
                     onTap: (){
                      //TODO : save userdetails
                    },
                   ),
           )



                
              ],),
            ],
          ),
          ),
        ],
      ),
         floatingActionButton: Align(
  alignment: Alignment.bottomCenter,
  child: Container(child: GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> const LoginPage()));
    },
    child: RichText(text: const TextSpan( text: 'Already have an account ? ',
    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:Colors.black87),
    //DefaultTextStyle.of(context).style,
    children: <TextSpan> [
      TextSpan(text: 'Login',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 12))
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