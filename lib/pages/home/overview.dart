import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Overview extends StatefulWidget {
  Overview({
    super.key,
  });

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  List<String> items = const <String>[
    'Water',
    'Calories',
    'Macro-nutrients',
    'Micro-nutrients',
    'Activity',
    'Blood Pressure',
    'Blood Sugar',
    'Blood Oxygen',
    'Resting Heart Rate',
    'Sleep Score',
  ];

  List<int> waterIntake = [400, 1200, 1500, 1350, 2000, 2200, 1200];
  List<int> calorieIntake = [1800, 2000, 2200, 1500, 2000, 2200, 1200];
  List<double> macroIntake = [65, 75, 35, 60, 70, 75, 90];
  List<double> microIntake = [20, 35, 25, 45, 35, 55, 35];
  List<double> activityLevel = [60, 30, 10, 50, 70, 40, 60];
  List<Map<String, int>> bloodPressure = [
    {
      'systolic': 120,
      'diastolic': 80,
    },
    {
      'systolic': 130,
      'diastolic': 85,
    },
    {
      'systolic': 110,
      'diastolic': 88,
    },
    {
      'systolic': 130,
      'diastolic': 90,
    },
    {
      'systolic': 120,
      'diastolic': 92,
    },
    {
      'systolic': 150,
      'diastolic': 95,
    },
    {
      'systolic': 130,
      'diastolic': 98,
    },
  ];
  List<double> bloodSugar = [4.5, 4.6, 4.7, 4.8, 3.9, 4.0, 5.1];
  List<double> bloodOxygen = [98, 96, 97, 96, 95, 97, 99];
  List<int> restingHeartRate = [70, 71, 72, 73, 64, 75, 76];
  List<int> sleepScore = [70, 71, 72, 73, 74, 75, 76];

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Smith (Male)'),
                    Text('Age: 26'),
                    Text('Height: 175cm'),
                    Text('Weight: 80kg'),
                    Text('BMI: 30'),
                  ],
                ),
              ),
              const Text('Accountability Picture'),
            ],
          ),
          const Center(
            child: Text(
              'Today (28th July 2024)',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: const EdgeInsets.all(8), child: Text('Chart Type')),
              DropdownMenu(
                  textStyle: const TextStyle(fontSize: 15),
                  dropdownMenuEntries: items.map((item) {
                    return DropdownMenuEntry(
                      value: item,
                      label: item,
                      labelWidget: Text(
                        item,
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList()),
            ],
          ),
          Container(
              padding: const EdgeInsets.all(18),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: LineChart(mainData())),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Water: 1000/2500ml'),
                Text('Calories: 1800/2200'),
                Text('Macro-nutrients: 65%'),
                Text('Micro-nutrients: 35%'),
                Text('Activity Level: 30%'),
                Text('Blood Pressure: 120/80mmHg'),
                Text('Blood Sugar: 5.5mg/dl'),
                Text('Blood Oxygen:95%'),
                Text('Resting Heart Rate: 70'),
                Text('Sleep Score: 70%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> gradientColors = [
    Colors.cyan,
    Colors.lightBlueAccent,
  ];

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.black,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: const FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 15,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
