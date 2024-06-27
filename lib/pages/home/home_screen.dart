import 'package:all_health_flutter/pages/home/hormones.dart';
import 'package:all_health_flutter/pages/home/microbiome.dart';
import 'package:all_health_flutter/pages/home/overview.dart';
import 'package:flutter/material.dart';

import 'body_composition.dart';
import 'dna_list.dart';
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
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Health'),
        ),
        bottomNavigationBar: Container(
            child: TabBar(
          tabs: [
            Tab(
              text: 'Overview',
            ),
            Tab(
              text: 'DNA',
            ),
            Tab(
              text: 'Hormones',
            ),
            Tab(
              text: 'Microbiome',
            ),
            Tab(
              text: 'Body Composition',
            ),
          ],
          onTap: (index) {
            setState(() {});
          },
        )),
        body: TabBarView(
          children: [
            Overview(),
            DnaList(),
            Hormones(),
            Microbiome(),
            BodyComposition(),
          ],
        ),
      ),
    ));
  }
}
