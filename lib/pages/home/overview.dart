import 'package:all_health_flutter/services/database_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

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

class DailyData {
  double water = 0;
  double calories = 0;
  double macroNutrients = 0;
  double microNutrients = 0;
  dynamic bloodPressure = {
    "systolic": 0,
    "diastolic": 0,
  };
  double bloodSugar = 0;
  double bloodOxygen = 0;
  double restingHeartRate = 0;
  double sleepScore = 0;
  double activity = 0;

  DailyData({
    required this.water,
    required this.calories,
    required this.macroNutrients,
    required this.microNutrients,
    required this.bloodPressure,
    required this.bloodSugar,
    required this.bloodOxygen,
    required this.restingHeartRate,
    required this.sleepScore,
    required this.activity,
  });
}

class DailyGoals {
  double water = 0;
  double calories = 0;

  DailyGoals({
    required this.water,
    required this.calories,
  });
}

final GetIt getIt = GetIt.instance;

class _OverviewState extends State<Overview> {
  Profile userInfo = Profile.fromJson({
    'id': 0,
    'name': 'John Smith',
    'dateOfBirth': '1990-01-01',
    'gender': 'Male ',
    'height': 175,
    'weight': 80,
  });

  DailyIntake dailyIntake = DailyIntake.fromJson({});
  DailyMonitoring dailyMonitoring = DailyMonitoring.fromJson({});

  @override
  void initState() {
    super.initState();
    getIt<DatabaseService>().getProfile().then((profile) {
      setState(() {
        userInfo = profile;
      });
    });

    getIt<DatabaseService>().getDailyIntake().then((intake) {
      setState(() {
        dailyIntake = intake;
      });
    });

    getIt<DatabaseService>().getDailyMonitoring().then((monitoring) {
      setState(() {
        dailyMonitoring = monitoring;
      });
    });
  }

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
      increment: 0,
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
    var dailyGoals = DailyGoals(
      water: 2500,
      calories: 2200,
    );

    double calculateBMI() {
      return userInfo.weight / (userInfo.height / 100 * userInfo.height / 100);
    }

    String calculateAge() {
      return (DateTime.now()
                  .difference(DateTime.parse(userInfo.dateOfBirth))
                  .inDays /
              365)
          .toStringAsFixed(0);
    }

    String todaysDate() {
      DateTime now = DateTime.now();
      String daySuffix(int day) {
        if (day >= 11 && day <= 13) {
          return 'th';
        }
        switch (day % 10) {
          case 1:
            return 'st';
          case 2:
            return 'nd';
          case 3:
            return 'rd';
          default:
            return 'th';
        }
      }

      List<String> months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
      ];
      String formattedDate =
          "${months[now.month - 1]} ${now.day}${daySuffix(now.day)} ${now.year}";
      return formattedDate;
    }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userInfo.name),
                    Text('Age: ${calculateAge()}'),
                    Text('Height: ${userInfo.height}cm'),
                    Text('Weight: ${userInfo.weight}kg'),
                    Text('BMI: ${calculateBMI().toStringAsFixed(2)}'),
                  ],
                ),
              ),
              const Text('Accountability Picture'),
            ],
          ),
          Center(
            child: Text(
              'Today (${todaysDate()})',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //         padding: const EdgeInsets.all(8),
          //         child: const Text('Chart Type')),
          //     DropdownMenu(
          //         controller: TextEditingController(
          //           text: selectedMetric,
          //         ),
          //         textStyle: const TextStyle(fontSize: 15),
          //         onSelected: (value) {
          //           setState(() {
          //             selectedMetric = value ?? "Water";
          //           });
          //         },
          //         dropdownMenuEntries: items.map((item) {
          //           return DropdownMenuEntry(
          //             value: item,
          //             label: item,
          //             labelWidget: Text(
          //               item,
          //               style: const TextStyle(fontSize: 15),
          //             ),
          //           );
          //         }).toList()),
          //   ],
          // ),
          // Container(
          //     padding: const EdgeInsets.all(18),
          //     width: MediaQuery.of(context).size.width,
          //     height: 200,
          //     child: LineChart(mainData())),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Water: ${dailyIntake.water}/${dailyGoals.water}ml'),
                Text(
                    'Calories: ${dailyIntake.calories}/${dailyGoals.calories}'),
                Text(
                    'Blood Pressure: ${dailyMonitoring.bloodPressure.isEmpty ? 'N/A' : '${dailyMonitoring.bloodPressure['systolic']}/${dailyMonitoring.bloodPressure['diastolic'] + "mmHg"}'} '),
                Text('Blood Sugar: ${dailyMonitoring.bloodSugar}mg/dl'),
                Text('Blood Oxygen: ${dailyMonitoring.bloodOxygen}%'),
                Text('Resting Heart Rate: ${dailyMonitoring.restingHeartRate}'),
                Text('Sleep Score: ${dailyMonitoring.sleepScore}%'),
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
        drawHorizontalLine: true,
        horizontalInterval: metricToGraphConfig[selectedMetric]?.increment ?? 1,
        verticalInterval: 10,
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
            reservedSize: 0,
            interval: 10,
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
      minX: 0,
      maxX: 6,
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
          color: Colors.white,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
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
