import 'package:diabetes_care_taker/COMPONENTS_PAGES/bloodGlucoseMonitoing.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/healthInsightsPage.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/insulinDosePage.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/medicationReminderPage.dart';
import 'package:diabetes_care_taker/PAGES/drawerPage.dart';
import 'package:diabetes_care_taker/PAGES/popupMenuPage.dart';
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
          actions: [
            popupMenuPage(),
          ],
          elevation: 10,
          // centerTitle: true,
          title: Text(
            "Diabetes Care Taker",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          bottom: TabBar(
            // isScrollable: true,
            // tabAlignment: TabAlignment.start,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.water_drop_sharp,
                  color: Colors.redAccent,
                ),
                child: Text(
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
                child: Text(
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
                child: Text(
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
                child: Text(
                  "Medication",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          bloodGlucoseMonitoring(),
          healthIsightsPage(),
          insulinDosePage(),
          medicationReminderPage(),
        ]),
      ),
    );
  }
}
