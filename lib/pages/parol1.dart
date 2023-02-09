import 'package:flutter/material.dart';
class Parol extends StatelessWidget {
  const Parol({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color.fromRGBO(112,166,255, 1.0),
      body:
      Padding(padding: EdgeInsets.fromLTRB(60, 150, 70, 150),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('Забыли пароль?',style: TextStyle(fontFamily: 'Inter', fontSize: 30),),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Text('Введите  свою информацию ниже или войдите в систему с другой учетной записью',style: TextStyle(fontFamily: 'Inter', fontSize: 15),),
        ],
      ),
      ),
      floatingActionButton:
      FloatingActionButton(onPressed: (){ },
        child: Icon(Icons.arrow_back_ios_new),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

    );
  }
}
