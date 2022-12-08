import 'dart:io';
import 'dart:io';

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
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../Utils/colors.utils.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:app/main.dart';

class DataController extends GetxController {
  final firebaseInstance = FirebaseFirestore.instance;
  Map myData = {"myData": '', 'fcm_token': ''};
  void onReady() {
    super.onReady();
    getFireStoreData();
    get_fcm_token();
  }

  Future<void> get_fcm_token() async {
    try {
      var response = await FirebaseMessaging.instance.getToken();
      myData['fcm_token'] = response;
      //print(response.data());
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  Future<void> getFireStoreData() async {
    try {
      var response =
          await firebaseInstance.collection("fcm-token").doc("User").get();
      if (response.exists) {
        myData['myData'] = response.data();
        //print(response.data());
      }
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
}
