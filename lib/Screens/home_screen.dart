// ignore_for_file: unnecessary_new, prefer_const_constructors, duplicate_ignore

import 'package:app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Utils/colors.utils.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

///////
///////////
//////////////
/////////////////
/////////////////////
///
///
///
final auth = FirebaseAuth.instance;
final ref = FirebaseDatabase.instance.ref('List');
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

////////////////////////////////////////////////////////

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_FirebaseMessagingBackgroundHandler);

  await FlutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(MyApp());
}

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
    List<String> strArr = [];
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
            child: new Column(children: [
              Text('List of ESPs Connected',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25)),
              Expanded(
                child: FirebaseAnimatedList(
                    query: ref,
                    itemBuilder: (context, snapshot, animation, index) {
                      index = index + 1;
                      if ("${snapshot.child('device').value.toString()}" ==
                          '0') {
                        strArr.add("$index");
                      }
                      return ListTile(
                        title: ElevatedButton.icon(
                          onPressed: () {
                            print(strArr);
                          },
                          icon: Icon(
                            // <-- Icon
                            Icons.switch_left,
                            size: 24.0,
                          ),
                          label: Text(
                              "ESP $index -------> ${snapshot.child('device').value.toString()} ",
                              style: const TextStyle(fontSize: 20)), // <-- Text
                        ),
                        textColor: Colors.black,
                      );
                    }),
              ),

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


