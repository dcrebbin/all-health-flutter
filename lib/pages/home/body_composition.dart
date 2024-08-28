import 'package:flutter/material.dart';

class BodyComposition {
  late final String name;
  late final String value;
  late final String units;
  late final Map<String, dynamic> referenceRange;
}

class BodyCompositionWidget extends StatelessWidget {
  const BodyCompositionWidget({
    required this.bodyComposition,
    super.key,
  });
  final List<BodyComposition> bodyComposition;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Body Composition'),
      ],
    );
  }
}
