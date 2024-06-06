import 'package:diabetes_care_taker/COMPONENTS_PAGES/model/educationLibraryPage.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/emergencyAlertPage.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/exerciseTrackingPage.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/testReminderPage.dart';
import 'package:diabetes_care_taker/connection/ConnectionClass.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class drawerPage extends StatelessWidget {
  const drawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Diabetes care taker",
            ),
            accountEmail: Text("diabetescaretaker@gmail.com"),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {
              ConnectionClass()
                  .connection_function_navigator(educationLibraryPage());
              // Get.to(educationLibraryPage());
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => educationLibraryPage(),
              //     ));
            },
            leading: Icon(Icons.library_books,
                color: Colors.black,
                size: MediaQuery.of(context).size.height * .033),
            title: Text(
              "Diabetes Education library",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => exerciseTrackingPage(),
                  ));
            },
            leading: Icon(
              Icons.run_circle_outlined,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * .033,
            ),
            title: Text(
              "Exercise Tracking",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => testReminderPage(),
                  ));
            },
            leading: Icon(
              Icons.add_alert_rounded,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * .033,
            ),
            title: Text(
              "Diabetes Related Test Reminders",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {
              ConnectionClass()
                  .connection_function_navigator(emergencyAlertPage());
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => emergencyAlertPage(),
              //       ));
            },
            leading: Icon(
              Icons.bus_alert,
              color: Colors.black,
              size: MediaQuery.of(context).size.height * .033,
            ),
            title: Text(
              "Emergency Alert",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            horizontalTitleGap: 0,
            onTap: () {},
            leading: Icon(
              Icons.logout,
              size: MediaQuery.of(context).size.height * .033,
              color: Colors.red,
            ),
            title: Text(
              "Logout",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
