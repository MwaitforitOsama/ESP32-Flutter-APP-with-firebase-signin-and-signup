import 'package:app/Screens/home_screen.dart';
import 'package:app/Screens/signup_screen.dart';
import 'package:app/reusable_widget/resuable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BuildContext,
        Container,
        LinearGradient,
        MaterialPageRoute,
        Scaffold,
        State,
        StatefulWidget,
        Widget;
import '../Utils/colors.utils.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

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
                    logoWidget("assets/images/LOGONEW.png"),
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
                    signInSignUpButton(context, true, () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      });
                    }),
                    signUpOption(context)
                  ])))),
    );
  }
}

////
//////
///////
////
///
Row signUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Don't have an account? ",
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: const Text(
          "Signup",
          style: TextStyle(
              color: Color.fromARGB(255, 5, 13, 125),
              fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}
