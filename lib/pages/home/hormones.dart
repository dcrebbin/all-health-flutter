import 'package:flutter/material.dart';

class Hormone {
  String units = '';
  Map<String, dynamic> referenceRange = {
    'min': 0,
    'max': 0,
  };
  double value = 0;
  String name = '';

  Hormone({
    required this.name,
    required this.units,
    required this.referenceRange,
    required this.value,
  });
}

class Hormones extends StatelessWidget {
  const Hormones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Hormone> hormones = [];

    hormones.add(Hormone(
      name: 'Free thyroxine (FT4)',
      units: 'pmol/L',
      referenceRange: {'min': 9.0, 'max': 25.0},
      value: 14,
    ));
    hormones.add(Hormone(
      name: 'Thyroid Stimulating Hormone',
      units: 'mlU/L',
      referenceRange: {'min': 0.4, 'max': 4.0},
      value: 2,
    ));
    hormones.add(Hormone(
      name: 'Free Tri-iodothyronine (FT3) ',
      units: 'pmol/L',
      referenceRange: {'min': 3.5, 'max': 6.5},
      value: 5,
    ));
    hormones.add(Hormone(
      name: 'Testosterone',
      units: 'nmol/L',
      referenceRange: {'min': 6.0, 'max': 28.0},
      value: 14,
    ));
    hormones.add(Hormone(
      name: 'SHBG re-std',
      units: 'nmol/L',
      referenceRange: {'min': 15, 'max': 50},
      value: 25,
    ));
    hormones.add(Hormone(
      name: 'Free Testosterone',
      units: 'pmol/L',
      referenceRange: {'min': 200, 'max': 600},
      value: 350,
    ));

    return Column(
      children: [
        const Text(
          'Hormones',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('Last updated: 2024-02-15'),
        Container(
          margin: const EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: hormones.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text("${hormones[index].name}: "),
                  Text(
                    hormones[index].value.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
