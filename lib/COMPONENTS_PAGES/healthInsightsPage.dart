// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class healthInsightsPage extends StatelessWidget {
//   const healthInsightsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(
//               'Daily Graph',
//               style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.red,
//                   decoration: TextDecoration.underline),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * .5,
//               width: double.maxFinite,
//               child: LineChart(
//                 LineChartData(
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: [
//                         FlSpot(0, 0),
//                         FlSpot(13, 100),
//                         FlSpot(16, 130),
//                         FlSpot(17, 200),
//                         FlSpot(22, 220),
//                         FlSpot(24, 350),
//                       ],
//                       barWidth: 1,
//                       color: Color.fromARGB(255, 5, 65, 114),
//                       isCurved: true,
//                       belowBarData: BarAreaData(
//                         color: Color.fromARGB(255, 5, 65, 114).withOpacity(0.2),
//                         show: true,
//                       ),
//                       aboveBarData: BarAreaData(
//                         color: Color.fromARGB(255, 5, 65, 114).withOpacity(0.1),
//                         show: true,
//                       ),
//                     ),
//                   ],
//                   titlesData: FlTitlesData(
//                     rightTitles: AxisTitles(
//                       axisNameWidget: Text(
//                         "Blood Glucose Level",
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 5, 65, 114),
//                         ),
//                       ),
//                       axisNameSize: 30,
//                     ),
//                     topTitles: AxisTitles(
//                       axisNameWidget: Text(
//                         "Time in Hours",
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 5, 65, 114),
//                         ),
//                       ),
//                       axisNameSize: 30,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             //////////////////////////////////

//             SizedBox(
//               height: MediaQuery.of(context).size.height * .05,
//             ),
//             Text(
//               'ALL Time Graph',
//               style: TextStyle(
//                   fontSize: 22,
//                   color: Colors.red,
//                   decoration: TextDecoration.underline),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * .5,
//               width: double.maxFinite,
//               child: LineChart(
//                 LineChartData(
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: [
//                         FlSpot(0, 0),
//                         FlSpot(1, 50),
//                         FlSpot(2, 100),
//                         FlSpot(3, 120),
//                         FlSpot(4, 200),
//                         FlSpot(5, 50),
//                         FlSpot(6, 130),
//                         FlSpot(7, 200),
//                         FlSpot(8, 220),
//                         FlSpot(9, 300),
//                         FlSpot(10, 130),
//                         FlSpot(11, 130),
//                         FlSpot(12, 200),
//                         FlSpot(13, 130),
//                         FlSpot(14, 220),
//                         FlSpot(15, 300),
//                         FlSpot(16, 350),
//                         FlSpot(17, 220),
//                         FlSpot(18, 300),
//                         FlSpot(19, 130),
//                         FlSpot(20, 50),
//                         FlSpot(21, 250),
//                         FlSpot(22, 50),
//                         FlSpot(23, 20),
//                         FlSpot(24, 130),
//                         FlSpot(25, 300),
//                         FlSpot(26, 250),
//                         FlSpot(27, 270),
//                         FlSpot(28, 220),
//                         FlSpot(29, 190),
//                         FlSpot(30, 200),
//                         FlSpot(31, 20),
//                         FlSpot(35, 300),
//                       ],
//                       barWidth: 1,
//                       color: Color.fromARGB(255, 5, 65, 114),
//                       isCurved: true,
//                       belowBarData: BarAreaData(
//                         color: Color.fromARGB(255, 5, 65, 114).withOpacity(0.2),
//                         show: true,
//                       ),
//                       aboveBarData: BarAreaData(
//                         color: Color.fromARGB(255, 5, 65, 114).withOpacity(0.1),
//                         show: true,
//                       ),
//                     ),
//                   ],
//                   titlesData: FlTitlesData(
//                     rightTitles: AxisTitles(
//                       axisNameWidget: Text(
//                         "Blood Glucose Level",
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 5, 65, 114),
//                         ),
//                       ),
//                       axisNameSize: 30,
//                     ),
//                     topTitles: AxisTitles(
//                       axisNameWidget: Text(
//                         "Time in Days",
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 5, 65, 114),
//                         ),
//                       ),
//                       axisNameSize: 30,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
              // Only buttons for graphs, above graphs are with some description in cards
              // SizedBox(
              //   height: 20,
              // ),
              // SizedBox(
              //   width: 200,
              //   height: 45,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => weeklyGraph(),
              //         ),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30.0),
              //       ),
              //     ),
              //     child: Text(
              //       'Generate Weekly Graph',
              //       style: TextStyle(fontSize: 17),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // SizedBox(
              //   width: 200,
              //   height: 45,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => monthlyGraph(),
              //         ),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30.0),
              //       ),
              //     ),
              //     child: Text(
              //       'Generate Monthly Graph',
              //       style: TextStyle(fontSize: 17),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
