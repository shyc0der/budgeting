// ignore_for_file: file_names

import 'package:budget/src/input.dart';
import 'package:budget/src/models/userModel.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:budget/src/modules/userModule.dart';
import 'package:budget/src/pages/background_page.dart';
import 'package:budget/src/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final UserModule _userModule = UserModule();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  bool fullNameError = false;
  bool emailError = false;
  bool emailInvalid = false;
  bool pswdError = false;
  bool phoneNoError = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundPage(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 28,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 27,
                    )),
                const SizedBox(
                  height: 68,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    inputField('FULL NAME', fullNameController, fullNameError),
                    inputField('EMAIL', emailController, emailError,
                        invalid: emailInvalid),
                    inputField('PASSWORD', pswdController, pswdError),
                    inputField('PHONE NUMBER', phoneNoController, phoneNoError,
                        keyboardType: TextInputType.phone),

                    const SizedBox(
                      height: 35,
                    ),
                    //sign up button

                    Align(
                      alignment: Alignment.bottomRight,
                      child: isLoading ? const CircularProgressIndicator() : CustomElavtedButton(
                          errorExists: false,
                          label:  'SIGN UP',
                          fontSize: 18,
                          iconData: Icons.arrow_forward,
                          onTap: isLoading
                              ? null
                              : () async {
                                  bool errorExist = false;

                                  if (fullNameController.text.isEmpty) {
                                    errorExist = true;
                                    setState(() {
                                      fullNameError = true;
                                    });
                                  }
                                  if (phoneNoController.text.isEmpty) {
                                    errorExist = true;
                                    setState(() {
                                      phoneNoError = true;
                                    });
                                  }
                                  if (emailController.text.isEmpty) {
                                    errorExist = true;
                                    setState(() {
                                      emailError = true;
                                    });
                                  }
                                  if (!GetUtils.isEmail(emailController.text)) {
                                    errorExist = true;
                                    setState(() {
                                      emailInvalid = true;
                                    });
                                  }

                                  // if no error exist save user
                                  if (!errorExist) {
                                    addUser();
                                  }
                                }),
                    )
                  ],
                ),
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
                    builder: (BuildContext context) => const LoginPage()));
          },
          child: RichText(
            text: const TextSpan(
                text: 'Already have an account ? ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black87),
                //DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Login',
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

  void addUser() async {
     setState(() {
      isLoading = true;
    });
    var _res = await _userModule.addUser(UserModel(
        email: emailController.text,
        phoneNumber: phoneNoController.text,
        password: pswdController.text,
        fullName: fullNameController.text));
        setState(() {
          isLoading = false;
         });
        

    if (_res.status == ResponseType.success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User created!"),
      ));
      // back
      Navigator.pop(context);
    } 
    else {
       if (_res.body == 'weak-password') {
        Get.showSnackbar(const GetSnackBar(
          title: 'Weak password',
          message: 'Weak password',
          backgroundColor: Colors.redAccent,
        ));
      }
       else if (_res.body == 'email-already-in-use') {
        Get.showSnackbar(GetSnackBar(
          title: 'Email already registered',
          message: 'Email already registered',
          isDismissible: true,
          backgroundColor: Colors.amber.withOpacity(.65),
        ));
        setState(() {
          emailInvalid = true;
        });
      } 
      else {
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: _res.body.toString(),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }
}
