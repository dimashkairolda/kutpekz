import 'package:flutter/material.dart';
class Active extends StatelessWidget {
  const Active({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset('assets/Empty_box.png', width: 340, height: 267,),
              const Text('У вас нет активных бронирований', style: TextStyle(fontFamily: 'San Francisco', fontWeight: FontWeight.w500, fontSize: 18),),
            ],
          ),
        ],
      ),
    );
  }
}
