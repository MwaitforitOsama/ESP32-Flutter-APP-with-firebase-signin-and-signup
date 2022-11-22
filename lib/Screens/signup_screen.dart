import 'package:app/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/colors.utils.dart';
import '../reusable_widget/resuable_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _UsernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("#1E90FF"),
              hexStringToColor("#6BB6FF")
            ])),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                          "Full Name",
                          IconData(0xe8ce, fontFamily: 'MaterialIcons'),
                          false,
                          _UsernameController),
                      SizedBox(
                        height: 30,
                      ),
                      reusableTextField(
                          "UserName",
                          IconData(0xe497, fontFamily: 'MaterialIcons'),
                          false,
                          _emailTextController),
                      SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                          "Password",
                          IconData(0xe3b1, fontFamily: 'MaterialIcons'),
                          true,
                          _passwordTextController),
                      SizedBox(
                        height: 30,
                      ),
                      signInSignUpButton(context, false, () {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          print("Created new account!");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                      })
                    ])))));
  }
}
