import 'package:flutter/material.dart';

class DnaList extends StatefulWidget {
  const DnaList({
    super.key,
  });

  @override
  State<DnaList> createState() => _DnaListState();
}

class _DnaListState extends State<DnaList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SearchBar(),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SnpContainer();
                  }),
            ),
          ],
        ));
  }
}

class SnpContainer extends StatelessWidget {
  const SnpContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("DNA"),
          )),
    );
  }
}
