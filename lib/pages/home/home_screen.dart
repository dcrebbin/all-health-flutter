import 'package:all_health_flutter/pages/home/hormones.dart';
import 'package:all_health_flutter/pages/home/microbiome.dart';
import 'package:all_health_flutter/pages/home/overview.dart';
import 'package:all_health_flutter/pages/home/vitamins.dart';
import 'package:flutter/material.dart';

import 'body_composition.dart';
import 'daily-intake.dart';
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
  'Daily Intake',
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
  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: tabs.length, initialIndex: selectedIndex, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 9,
      child: Scaffold(
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
        body: TabBarView(
          controller: tabController,
          children: [
            Overview(),
            const Progress(),
            const DailyIntake(),
            const Exercise(),
            const Vitamins(),
            const Hormones(),
            const Microbiome(),
            const DnaList(),
          ],
        ),
      ),
    ));
  }
}
