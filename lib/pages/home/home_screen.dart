import 'package:all_health_flutter/pages/home/hormones.dart';
import 'package:all_health_flutter/pages/home/microbiome.dart';
import 'package:all_health_flutter/pages/home/overview.dart';
import 'package:all_health_flutter/pages/home/vitamins.dart';
import 'package:all_health_flutter/services/database_service.dart';
import 'package:flutter/material.dart';

import 'body_composition.dart';
import 'dna_list.dart';
import 'exercise.dart';
import 'progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

const tabs = [
  'Overview',
  'Progress',
  // 'Daily Intake',
  'Exercise',
  'Vitamins',
  'Body Composition',
  'Hormones',
  'Microbiome',
  'DNA',
];

int selectedIndex = 0;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool modalVisible = false;
  String selectedMetric = "Water";
  TextEditingController valueController = TextEditingController();
  late DailyIntake dailyIntake;
  late DailyMonitoring dailyMonitoring;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: tabs.length, initialIndex: selectedIndex, vsync: this);
    getIt<DatabaseService>().getDailyIntake().then((value) {
      setState(() {
        dailyIntake = value;
        valueController.text = dailyIntake.water.toString();
        print(dailyIntake.water);
      });
    });
    getIt<DatabaseService>().getDailyMonitoring().then((value) {
      setState(() {
        dailyMonitoring = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 7,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              modalVisible = !modalVisible;
            });
          },
          child: const Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView.builder(
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  tabController.animateTo(index);
                },
                child: Text(tabs[index]),
              ));
            },
          ),
        ),
        appBar: AppBar(
          title: const Text('All Health'),
        ),
        bottomNavigationBar: TabBar(
          controller: tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: tabController,
              children: [
                Overview(),
                const Progress(),
                // DailyIntakeWidget(dailyIntake: dailyIntake),
                const Exercise(),
                const Vitamins(),
                const BodyCompositionWidget(bodyComposition: []),
                const Hormones(),
                const Microbiome(),
                const DnaList(),
              ],
            ),
            Visibility(
              visible: modalVisible,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        modalVisible = false;
                      });
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Update',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      modalVisible = false;
                                    });
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text("Metric",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                            DropdownButton<String>(
                              value: selectedMetric,
                              items: [
                                "Water",
                                "Calories",
                                "Blood Pressure",
                                "Blood Sugar",
                                "Blood Oxygen",
                                "Heart Rate",
                                "Sleep Score"
                              ].map((e) {
                                return DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedMetric = value!;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: valueController,
                              decoration: const InputDecoration(
                                  labelText: "Value", hintText: "Value"),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (valueController.text.isEmpty) {
                                  return;
                                }
                                final dailyIntake =
                                    getIt<DatabaseService>().dailyIntake;
                                setState(() async {
                                  modalVisible = false;
                                  switch (selectedMetric) {
                                    case "Water":
                                      dailyIntake.water =
                                          int.parse(valueController.text);
                                      break;
                                    case "Calories":
                                  }
                                  await getIt<DatabaseService>()
                                      .insertDailyIntake(dailyIntake);
                                });
                              },
                              child: const Text("Update"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
