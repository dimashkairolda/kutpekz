import 'package:flutter/material.dart';
import 'package:kutpekz/pages/signup_page.dart';

// TODO - MAKE IMAGE SLIDER

class FirstOnboardPage extends StatelessWidget {
  const FirstOnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(112, 166, 255, 1.0),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Onboard1.png'),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Text(
                'Зарегистрируйтесь',
                style: TextStyle(fontSize: 20),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              const Text(
                ('Пройдите регистрацию и бронируйте время'),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          )
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: FloatingActionButton.extended(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                'Пропустить',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Color.fromRGBO(224, 239, 218, 1.0),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: FloatingActionButton.extended(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.pushNamed(context, '/onboard2');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                'Далее',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Color.fromRGBO(224, 239, 218, 1.0),
            ),
          ),
        ],
      ),
    );
  }
}
