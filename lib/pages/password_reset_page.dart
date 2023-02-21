import 'package:flutter/material.dart';
class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [

          Positioned(
              top: 20,

              child: FloatingActionButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new),
                backgroundColor: Color.fromRGBO(112,166,255, 1.0),

          )
          )
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

    );
  }
}
