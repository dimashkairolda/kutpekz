import 'package:flutter/material.dart';
class ThirdOnboardPage extends StatelessWidget {
  const ThirdOnboardPage({Key? key}) : super(key: key);

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
              Image.asset('assets/Onboard3.png'),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text('Оплатите онлайн', style: TextStyle( fontSize: 20),),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(('Найдите ближайщую автомойку и забронируйте'), style: TextStyle( fontSize: 15, color: Colors.white),)

            ],
          )

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey(),
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
