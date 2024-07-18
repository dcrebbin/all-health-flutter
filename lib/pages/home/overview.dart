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

class Metric {
  List<double> data = [];
  double min = 0;
  double max = 0;
  double increment = 0;

  Metric({
    required this.data,
    required this.min,
    required this.max,
    required this.increment,
  });
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

  String selectedMetric = "Water";

  Map<String, Metric> metricToGraphConfig = {
    "Water": Metric(
      data: [400, 1200, 1500, 1350, 2000, 2200, 1200],
      min: 0,
      max: 2500,
      increment: 500,
    ),
    "Calories": Metric(
      data: [1800, 2000, 2200, 1500, 2000, 2200, 1200],
      min: 0,
      max: 2500,
      increment: 500,
    ),
    "Macro-nutrients": Metric(
      data: [65, 75, 35, 60, 70, 75, 90],
      min: 0,
      max: 100,
      increment: 10,
    ),
    "Micro-nutrients": Metric(
      data: [20, 35, 25, 45, 35, 55, 35],
      min: 0,
      max: 100,
      increment: 10,
    ),
    "Activity": Metric(
      data: [60, 30, 10, 50, 70, 40, 60],
      min: 0,
      max: 100,
      increment: 10,
    ),
    "Blood Pressure": Metric(
      data: [120, 130, 110, 130, 120, 150, 130],
      min: 0,
      max: 100,
      increment: 10,
    ),
    "Blood Sugar": Metric(
      data: [4.5, 4.6, 4.7, 4.8, 3.9, 4.0, 5.1],
      min: 0,
      max: 10,
      increment: 0.1,
    ),
    "Blood Oxygen": Metric(
      data: [98, 96, 97, 96, 95, 97, 99],
      min: 0,
      max: 100,
      increment: 10,
    ),
    "Resting Heart Rate": Metric(
      data: [70, 71, 72, 73, 64, 75, 76],
      min: 0,
      max: 100,
      increment: 10,
    ),
    "Sleep Score": Metric(
      data: [70, 71, 72, 73, 74, 75, 76],
      min: 0,
      max: 100,
      increment: 10,
    ),
  };

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
                  padding: const EdgeInsets.all(8),
                  child: const Text('Chart Type')),
              DropdownMenu(
                  textStyle: const TextStyle(fontSize: 15),
                  onSelected: (value) {
                    setState(() {
                      selectedMetric = value ?? "Water";
                    });
                  },
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
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: metricToGraphConfig[selectedMetric]?.increment ?? 1,
            reservedSize: 40,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: 7,
      minY: metricToGraphConfig[selectedMetric]?.min ?? 0,
      maxY: metricToGraphConfig[selectedMetric]?.max ?? 100,
      lineBarsData: [
        LineChartBarData(
          spots: metricToGraphConfig[selectedMetric]
                  ?.data
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList() ??
              [],
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
