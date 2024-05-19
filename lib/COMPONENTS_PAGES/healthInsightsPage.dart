import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class healthInsightsPage extends StatelessWidget {
  const healthInsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Daily Graph',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  decoration: TextDecoration.underline),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .5,
              width: double.maxFinite,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 0),
                        FlSpot(13, 100),
                        FlSpot(16, 130),
                        FlSpot(17, 200),
                        FlSpot(22, 220),
                        FlSpot(24, 350),
                      ],
                      barWidth: 1,
                      color: Color.fromARGB(255, 5, 65, 114),
                      isCurved: true,
                      belowBarData: BarAreaData(
                        color: Color.fromARGB(255, 5, 65, 114).withOpacity(0.2),
                        show: true,
                      ),
                      aboveBarData: BarAreaData(
                        color: Color.fromARGB(255, 5, 65, 114).withOpacity(0.1),
                        show: true,
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      axisNameWidget: Text(
                        "Blood Glucose Level",
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 65, 114),
                        ),
                      ),
                      axisNameSize: 30,
                    ),
                    topTitles: AxisTitles(
                      axisNameWidget: Text(
                        "Time in Hours",
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 65, 114),
                        ),
                      ),
                      axisNameSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            //////////////////////////////////

            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Text(
              'ALL Time Graph',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.red,
                  decoration: TextDecoration.underline),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .5,
              width: double.maxFinite,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 0),
                        FlSpot(1, 50),
                        FlSpot(2, 100),
                        FlSpot(3, 120),
                        FlSpot(4, 200),
                        FlSpot(5, 50),
                        FlSpot(6, 130),
                        FlSpot(7, 200),
                        FlSpot(8, 220),
                        FlSpot(9, 300),
                        FlSpot(10, 130),
                        FlSpot(11, 130),
                        FlSpot(12, 200),
                        FlSpot(13, 130),
                        FlSpot(14, 220),
                        FlSpot(15, 300),
                        FlSpot(16, 350),
                        FlSpot(17, 220),
                        FlSpot(18, 300),
                        FlSpot(19, 130),
                        FlSpot(20, 50),
                        FlSpot(21, 250),
                        FlSpot(22, 50),
                        FlSpot(23, 20),
                        FlSpot(24, 130),
                        FlSpot(25, 300),
                        FlSpot(26, 250),
                        FlSpot(27, 270),
                        FlSpot(28, 220),
                        FlSpot(29, 190),
                        FlSpot(30, 200),
                        FlSpot(31, 20),
                        FlSpot(35, 300),
                      ],
                      barWidth: 1,
                      color: Color.fromARGB(255, 5, 65, 114),
                      isCurved: true,
                      belowBarData: BarAreaData(
                        color: Color.fromARGB(255, 5, 65, 114).withOpacity(0.2),
                        show: true,
                      ),
                      aboveBarData: BarAreaData(
                        color: Color.fromARGB(255, 5, 65, 114).withOpacity(0.1),
                        show: true,
                      ),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      axisNameWidget: Text(
                        "Blood Glucose Level",
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 65, 114),
                        ),
                      ),
                      axisNameSize: 30,
                    ),
                    topTitles: AxisTitles(
                      axisNameWidget: Text(
                        "Time in Days",
                        style: TextStyle(
                          color: Color.fromARGB(255, 5, 65, 114),
                        ),
                      ),
                      axisNameSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
