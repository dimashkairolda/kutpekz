import 'package:flutter/material.dart';

import '../signup_page.dart';

class SecondOnboardPage extends StatelessWidget {
  const SecondOnboardPage({Key? key}) : super(key: key);

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
              Image.asset('assets/Onboard2.png'),
              Padding(padding: EdgeInsets.only(top: 20)),
              Text('Забронируйте авто мойку', style: TextStyle(fontSize: 20),),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(('Найдите ближайщую автомойку и забронируйте'), style: TextStyle(fontSize: 15, color: Colors.white),)

            ],
          )

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton.extended(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text('Пропустить',style: TextStyle(color: Colors.black),),
        backgroundColor: Color.fromRGBO(224, 239, 218, 1.0),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton.extended(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.pushNamed(context, '/onboard3');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text('Далее',style: TextStyle(color: Colors.black),),
            backgroundColor: Color.fromRGBO(224, 239, 218, 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
