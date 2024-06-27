import 'package:flutter/material.dart';

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
      length: 4,
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
          ],
          onTap: (index) {
            setState(() {});
          },
        )),
        body: TabBarView(
          children: [
            Test(),
            DnaList(),
            Test(),
            Test(),
          ],
        ),
      ),
    ));
  }
}
