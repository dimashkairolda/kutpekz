import 'package:flutter/material.dart';
class onboard3 extends StatelessWidget {
  const onboard3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(112,166,255, 1.0),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('Onboard3.png'),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text('Оплатите онлайн', style: TextStyle(fontFamily: 'Inter', fontSize: 20),),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(('Найдите ближайщую автомойку и забронируйте'), style: TextStyle(fontFamily: 'Inter', fontSize: 15, color: Colors.white),)

            ],
          )

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/signup');
        },
        label:  Text('Начать', style: TextStyle(color: Colors.black),),
      backgroundColor: Color.fromRGBO(224, 239, 218, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

      ),
    );
  }
}
