import 'package:flutter/material.dart';

class BodyComposition {
  final String name = '';
  final String value = '';
  final String units = '';
  final Map<String, dynamic> referenceRange = {};
}

class BodyCompositionWidget extends StatelessWidget {
  const BodyCompositionWidget({
    super.key,
    required this.bodyComposition,
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
