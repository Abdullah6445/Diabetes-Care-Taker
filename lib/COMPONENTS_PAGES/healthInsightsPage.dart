import 'package:flutter/material.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/dailyGraph.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/weeklyGraph.dart';
import 'package:diabetes_care_taker/COMPONENTS_PAGES/monthlyGraph.dart';

class healthIsightsPage extends StatefulWidget {
  const healthIsightsPage({super.key});

  @override
  State<healthIsightsPage> createState() => _healthIsightsPageState();
}

class _healthIsightsPageState extends State<healthIsightsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Health Insights & Trends',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => dailyGraph(),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Graph',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Track your daily blood glucose trends over time to monitor your health and make informed decisions about your daily activities and diet'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => dailyGraph(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Show Daily Graph',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => weeklyGraph(),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weekly Graph',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Visualize your entire weeks blood glucose readings, including daily averages, to understand trends over the week and make informed health decisions'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => weeklyGraph(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Show Weekly Graph',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => monthlyGraph(),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Graph',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'View your comprehensive monthly blood glucose trends, displaying daily readings average and overall patterns, to gain deeper insights into your long-term health'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => monthlyGraph(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Show Monthly Graph',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
