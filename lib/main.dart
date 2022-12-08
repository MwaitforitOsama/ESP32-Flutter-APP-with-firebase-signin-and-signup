import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/signin_screen.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Utils/colors.utils.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:app/reusable_widget/firestore_data.dart';
import 'package:get/get.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var my_fcm_toke = await FirebaseMessaging.instance.getToken();
  final DataController controller = Get.put(DataController());
  var users_collection = await FirebaseFirestore.instance
      .collection("fcm-token")
      .doc("User")
      .get();
  var keys = users_collection.data();
  bool check_token_exist = false;
  if (keys != null) {
    keys.forEach((k, v) {
      if (k.toString() == my_fcm_toke.toString()) {
        check_token_exist = true;
      }
    });
  }
  if (check_token_exist == false) {
    await FirebaseFirestore.instance
        .collection("fcm-token")
        .doc("User")
        .update({
      my_fcm_toke.toString(): {},
    });
  }
  runApp(const MyApp());
}

String? mtoken = " ";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SigninScreen(),
    );
    bool status = false;
  }
}
