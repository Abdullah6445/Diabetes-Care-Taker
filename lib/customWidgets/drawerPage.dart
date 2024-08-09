import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_care_taker/drawer/educationLibrary/educationLibraryPage.dart';
import 'package:diabetes_care_taker/drawer/emergencyAlert/emergencyAlertPage.dart';
import 'package:diabetes_care_taker/drawer/exerciseTracking/exerciseTrackingPage.dart';
import 'package:diabetes_care_taker/drawer/dabetesRelatedTest/testTablePage.dart';
import 'package:diabetes_care_taker/customWidgets/customToastPage.dart';
import 'package:diabetes_care_taker/connection/ConnectionClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class drawerPage extends StatefulWidget {
  drawerPage({super.key});

  @override
  State<drawerPage> createState() => _drawerPageState();
}

class _drawerPageState extends State<drawerPage> {
  final _auth = FirebaseAuth.instance;

  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('about_user')
            .doc(uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'];
          });
          print('User Name.......:$userName');
        }
      }
    } catch (e) {
      CustomToast(message: 'Error occured while fetching user name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            width: 320,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.primary,
              ),
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/white_dtc_logo_horizontal.png',
                    scale: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    userName.isEmpty ? '' : 'Welcome, $userName',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {
              ConnectionClass()
                  .connection_function_navigator(const educationLibraryPage());
            },
            leading: Icon(Icons.library_books,
                color: Colors.black,
                size: MediaQuery.of(context).size.height * .033),
            title: const Text(
              "Diabetes Education library",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => exerciseLogScreen(),
                  ));
            },
            leading: Icon(
              Icons.run_circle_outlined,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * .033,
            ),
            title: const Text(
              "Exercise Tracking",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const testTablePage(),
                  ));
            },
            leading: Icon(
              Icons.add_alert_rounded,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * .033,
            ),
            title: const Text(
              "Diabetes Related Tests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {
              Get.to(const emergencyAlertPage());
            },
            leading: Icon(
              Icons.bus_alert,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * .033,
            ),
            title: const Text(
              "Emergency Alert",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () async {
              await _auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            leading: Icon(
              Icons.logout,
              size: MediaQuery.of(context).size.height * .033,
              color: Colors.red,
            ),
            title: Text(
              "Logout",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ?.copyWith(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
