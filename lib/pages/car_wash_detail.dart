import 'package:flutter/material.dart';
import 'package:kutpekz/car_washes_model.dart';

class CarWashDetail extends StatelessWidget {
  final CarWashes carWash;
  const CarWashDetail({Key? key, required this.carWash,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(carWash.getName)),
      body: Column(
        children: [
          Text(carWash.getAddress),
        ],
      ),
    );
  }
}
