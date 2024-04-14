import 'package:diabetes_care_taker/COMPONENTS_PAGES/bloodMonitoringPage.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/healthInsightsPage.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/insulinDosePage.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/medicationReminderPage.dart';
import 'package:diabetes_care_taker/PAGES/drawerPage.dart';
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
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: ListTile(
                  onTap: () {},
                  horizontalTitleGap: 0,
                  leading:
                      Icon(Icons.info_outline_rounded, color: Colors.black),
                  title: Text("ABOUT App"),
                )),
                PopupMenuItem(
                    child: ListTile(
                  onTap: () {},
                  horizontalTitleGap: 0,
                  leading: Icon(Icons.contact_emergency_outlined,
                      color: Colors.black),
                  title: Text("Contact Us"),
                )),
                PopupMenuItem(
                    child: ListTile(
                  onTap: () {},
                  horizontalTitleGap: 0,
                  leading:
                      Icon(Icons.help_center_outlined, color: Colors.black),
                  title: Text("Help"),
                )),
                PopupMenuItem(
                    child: ListTile(
                  onTap: () {},
                  horizontalTitleGap: 0,
                  leading: Icon(Icons.group, color: Colors.black),
                  title: Text("Developers"),
                )),
                PopupMenuItem(
                    child: ListTile(
                  onTap: () {},
                  horizontalTitleGap: 0,
                  leading: Icon(Icons.menu_book_sharp, color: Colors.black),
                  title: Text("Terms and Privacy Policy"),
                )),
              ],
            )
          ],
          elevation: 10,
          // centerTitle: true,
          title: Text(
            "Diabetes Care Taker",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.water_drop_sharp,
                  color: Colors.redAccent,
                ),
                child: Text("Blood Glucose Monitoring"),
              ),
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.health_and_safety,
                  color: Colors.blue,
                ),
                child: Text("Health Insights & Trends"),
              ),
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.calculate,
                  color: Colors.greenAccent,
                ),
                child: Text("Insulin Dose Calculation"),
              ),
              Tab(
                icon: Icon(
                  size: MediaQuery.of(context).size.height * .04,
                  Icons.alarm_add,
                  color: Colors.orangeAccent,
                ),
                child: Text("Medication Reminder"),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          bloodMonitoringPage(),
          healthInsightsPage(),
          insulinDosePage(),
          medicationReminderPage(),
        ]),
      ),
    );
  }
}
