import 'package:diabetes_care_taker/dashboard/bloodMonitoring/bloodGlucoseMonitoing.dart';
import 'package:diabetes_care_taker/dashboard/healthInsights/healthInsightsPage.dart';
import 'package:diabetes_care_taker/dashboard/insulinDose/insulinDosePage.dart';
import 'package:diabetes_care_taker/dashboard/medicationReminder/medicationReminderPage.dart';
import 'package:diabetes_care_taker/customWidgets/drawerPage.dart';
import 'package:diabetes_care_taker/popUpButton/popupMenuPage.dart';
import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: drawerPage(),
        appBar: AppBar(
          actions: const [
            popupMenuPage(),
          ],
          elevation: 10,
          title: const Text(
            "Diabetes Care Taker",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          bottom: TabBar(
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.water_drop_sharp,
                  color: Colors.redAccent,
                ),
                child: const Text(
                  "Blood Glocuse Monitoring",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.health_and_safety,
                  color: Colors.blue,
                ),
                child: const Text(
                  "Insights & Trends",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.calculate,
                  color: Colors.greenAccent,
                ),
                child: const Text(
                  "Insulin Dose Calculation",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.alarm_add,
                  color: Colors.orangeAccent,
                ),
                child: const Text(
                  "Medication",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          const bloodGlucoseMonitoring(),
          const healthIsightsPage(),
          insulinDosePage(),
          const medicationReminderPage(),
        ]),
      ),
    );
  }
}
