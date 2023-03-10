import 'package:flutter/material.dart';
class Active extends StatelessWidget {
  const Active({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset('assets/Empty_box.png', width: 340, height: 267,),

              SizedBox(
                height: 100,
                width: 330,
                child:
                Text('У вас нет активного бронирования автомойки', style: TextStyle(fontFamily: 'San Francisco', fontWeight: FontWeight.w500, fontSize: 20),),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
