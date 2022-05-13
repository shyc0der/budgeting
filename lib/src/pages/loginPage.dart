// ignore_for_file: file_names

import 'package:budget/src/input.dart';
import 'package:budget/src/modules/firebaseUserModule.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:budget/src/modules/userModule.dart';
import 'package:budget/src/pages/main.dart';
import 'package:budget/src/pages/signUpPage.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserModule userModule = UserModule();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  bool emailError = false;
  bool pswdError = false;
  bool emailInvalid = false;
  bool isLoading = false;
  bool passwordInvalid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 150, child: BackgroundPage()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text Login
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.black),
                  ),
                ),
                //text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Please Sign In To Continue',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black87),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                inputField(
                  'EMAIL',
                  emailController,
                  emailError,
                  invalid: emailInvalid,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      setState(() {
                        emailError = false;
                        emailInvalid = false;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                inputField('Password', pswdController, pswdError,
                    isHidden: true,
                    invalid: passwordInvalid, onChanged: (String val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      pswdError = false;
                      passwordInvalid = false;
                    });
                  }
                }),
                const SizedBox(
                  height: 45,
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomElavtedButton(
                      errorExists: false,
                      label: 'Login',
                      fontSize: 20,
                      iconData: Icons.arrow_forward,
                      onTap: () async {
                        bool _errExist = false;
                        if (emailController.text.isEmpty) {
                          setState(() {
                            emailError = true;
                            _errExist = true;
                          });
                        }
                        if (pswdController.text.isEmpty) {
                          setState(() {
                            pswdError = true;
                            _errExist = true;
                          });
                        }
                        if (!GetUtils.isEmail(emailController.text)) {
                          setState(() {
                            emailInvalid = true;
                            _errExist = true;
                          });
                        }
                        if (!_errExist) {
                          setState(() {
                            isLoading = true;
                          });
                          final _res = await FirebaseUser.login(
                              emailController.text, pswdController.text);
                          await Future.delayed(const Duration(seconds: 1));
                          if (_res.status == ResponseType.success) {
                            // get user
                            await userModule.setCurrentUser(_res.body.toString());  
                           await  Get.offAndToNamed('/');                         


                        await  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  FirstPage(userid:_res.body.toString())));
                          }
                          if (_res.body == 'user-not-found') {
                            setState(() {
                              emailInvalid = true;
                            });
                          }
                          if (_res.body == 'wrong-password') {
                            setState(() {
                              passwordInvalid = true;
                            });
                          }

                          setState(() {
                            isLoading = false;
                          });
                        }
                      }),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SignUpPage()));
          },
          child: RichText(
            text: const TextSpan(
                text: 'Do not have an Account ? ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black87),
                //DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(194, 72, 38, 1),
                          fontSize: 12))
                ]),
          ),
        ),
      ),
    );
  }
}
