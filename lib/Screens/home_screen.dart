// ignore_for_file: unnecessary_new, prefer_const_constructors, duplicate_ignore

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

import '../Utils/colors.utils.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:app/main.dart';

///////
///////////
//////////////
/////////////////
/////////////////////
///
///
///
final auth = FirebaseAuth.instance;
final ref = FirebaseDatabase.instance.ref('Link');

// final ref_users =
//     FirebaseDatabase.instance.ref('Link').child('Link').toString();
////////////////
////////////////
///
///
///
///
////
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'For ESP Notifications', 'ESP Turned on',
    importance: Importance(1), playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _FirebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Notification for the Esps');
}

Future updateDB(String token, Map rand) async {
  return await FirebaseFirestore.instance
      .collection("fcm-token")
      .doc("User")
      .update({token: rand});
}

////////////////////////////////////////////////////////

///
///
//////////////
//////////////////

///

bool status = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  get isSwitched => null;

  @override
  Widget build(BuildContext context) {
    var index = 0;
    bool first_time = true;
    Map randata_temp = {};
    List<String> strArr = [];
    bool switch_value = true;

    return Scaffold(
        appBar: AppBar(
          title: Text('ESP APP'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                icon: const Icon(Icons.logout))
          ],
          backgroundColor: Colors.black87,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(2),
                  bottomRight: Radius.circular(2))),
        ),

        ///
        ///
        ///
        ///
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("#1E90FF"),
              hexStringToColor("#6BB6FF")

/////////CODE CHUNK
              ///
              ///

/////
              ///
              ///CODE CHUNK
            ])),
            // ignore: unnecessary_new
            child: new Column(children: <Widget>[
              Text('List of ESPs Connected',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
              new Flexible(
                  child: FirebaseAnimatedList(
                      query: ref,
                      itemBuilder: (context, snapshot, animation, index) {
                        index = index + 1;
                        Map mydata = snapshot.value as Map;
                        mydata['key'] = snapshot.key;
                        var text_to_display = mydata.keys.toList().first;
                        var color_to_chose = null;
                        var randata = null;
                        FirebaseFirestore.instance
                            .collection('fcm-token')
                            .doc('User')
                            .get()
                            .then((DocumentSnapshot documentSnapshot) {
                          if (documentSnapshot.exists) {
                            print('Document data: ${documentSnapshot.data()}');
                            FirebaseMessaging.instance.getToken().then((value) {
                              Map randata = documentSnapshot.data() as Map;
                              if (first_time) {
                                randata_temp = randata[value] as Map;
                                first_time = false;
                              }
                              if (!randata_temp.containsKey(text_to_display)) {
                                randata_temp[text_to_display] = true;
                                updateDB(value.toString(), randata_temp);
                                sleep(Duration(seconds: 2));
                              }
                            });
                          } else {
                            print('Document does not exist on the database');
                          }
                        });
                        print(text_to_display);
                        if (mydata[text_to_display] == 0) {
                          color_to_chose = Colors.red;
                        } else {
                          color_to_chose = Colors.green;
                        }
                        return new SwitchListTile(
                            title: Text(text_to_display,
                                style: const TextStyle(fontSize: 20)),
                            subtitle: Text("This is $text_to_display"),
                            value: switch_value,
                            activeColor: Color.fromARGB(255, 4, 250, 160),
                            controlAffinity: ListTileControlAffinity.leading,
                            secondary: Icon(
                              Icons.add_moderator,
                              color: color_to_chose,
                            ),
                            onChanged: (switch_value) {
                              switch_value = !switch_value;
                            });

                        // return new Row(
                        //   children: [
                        //     Text(mydata.keys.toList().first,
                        //         style: const TextStyle(fontSize: 20)),
                        //     Switch(
                        //         value: false,
                        //         onChanged: (value) {
                        //           print("VALUE : $value");
                        //         })
                        //   ],
                        // );
                      }))

              //

              /////

              /////

              //

              // Expanded Onwards

              // Expanded(
              //   child: signInSignUpButton2(context, true, () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MyApp()));
              //   }),
              // )
            ]))

        ////
        ////ENDS

        );

    ///Ends HERE///
  }
}








//  title: TextButton.icon(
//                           onPressed: () {
//                             print("Hello");
//                           },
//                           icon: Icon(
//                             // <-- Icon
//                             Icons.toggle_on,
//                             size: 24.0,
//                           ),
//                           label: Text(snapshot.value.toString(),
//                               style: const TextStyle(fontSize: 20)), // <-- Text
//                         ),
//                         textColor: Colors.black,




/////
///
///
// ///
// class CustomSwitch extends StatefulWidget {
//   final bool value;
//   final ValueChanged<bool> onChanged;

//   CustomSwitch({Key? key, required this.value, required this.onChanged})
//       : super(key: key);

//   @override
//   _CustomSwitchState createState() => _CustomSwitchState();
// }

// class _CustomSwitchState extends State<CustomSwitch>
//     with SingleTickerProviderStateMixin {
//   Animation? _circleAnimation;
//   AnimationController? _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 60));
//     _circleAnimation = AlignmentTween(
//             begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
//             end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
//         .animate(CurvedAnimation(
//             parent: _animationController!, curve: Curves.linear));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animationController!,
//       builder: (context, child) {
//         return GestureDetector(
//           onTap: () {
//             if (_animationController!.isCompleted) {
//               _animationController!.reverse();
//             } else {
//               _animationController!.forward();
//             }
//             widget.value == false
//                 ? widget.onChanged(true)
//                 : widget.onChanged(false);
//           },
//           child: Container(
//             width: 45.0,
//             height: 28.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24.0),
//               color: _circleAnimation!.value == Alignment.centerLeft
//                   ? Colors.grey
//                   : Colors.blue,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
//               child: Container(
//                 alignment:
//                     widget.value ? Alignment.centerRight : Alignment.centerLeft,
//                 child: Container(
//                   width: 20.0,
//                   height: 20.0,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


