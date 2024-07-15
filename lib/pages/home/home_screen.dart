import 'package:all_health_flutter/pages/home/hormones.dart';
import 'package:all_health_flutter/pages/home/microbiome.dart';
import 'package:all_health_flutter/pages/home/overview.dart';
import 'package:all_health_flutter/pages/home/vitamins.dart';
import 'package:flutter/material.dart';

import 'body_composition.dart';
import 'daily-intake.dart';
import 'dna_list.dart';
import 'exercise.dart';
import 'test_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Health'),
        ),
        bottomNavigationBar: const TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: [
            Tab(text: 'Overview'),
            Tab(text: 'Daily Intake'),
            Tab(text: 'Exercise'),
            Tab(text: 'Vitamins'),
            Tab(text: 'Body Composition'),
            Tab(text: 'Hormones'),
            Tab(text: 'Microbiome'),
            Tab(text: 'DNA'),
          ],
        ),
        body: TabBarView(
          children: [
            Overview(),
            const DailyIntake(),
            const Exercise(),
            const Vitamins(),
            const BodyComposition(),
            const Hormones(),
            const Microbiome(),
            const DnaList(),
          ],
        ),
      ),
    ));
  }
}
