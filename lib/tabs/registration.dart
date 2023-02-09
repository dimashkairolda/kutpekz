import 'package:flutter/material.dart';
class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(112,166,255, 1.0),
      body: Padding(padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
        child:
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

              Image.asset('Onboard1.png'),
              TextField(style: TextStyle(fontFamily: 'Inter'),
                decoration: InputDecoration(
                hintText: 'Номер телефона',

              ),
              ),
          TextField(style: TextStyle(fontFamily: 'Inter'),
            decoration: InputDecoration(
            hintText: 'Пароль',
          ),
          ),
          TextField(style: TextStyle(fontFamily: 'Inter'),
            decoration: InputDecoration(
            hintText: 'Повторите пароль',

          ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          MaterialButton(onPressed: (){},
            color: Color.fromRGBO(224, 239, 218, 1.0),
            child: Text('Войти',style: TextStyle(fontFamily: 'Inter'),),
            minWidth: 500,



          ),


        ],
      ),
      ),
    );
  }
}
