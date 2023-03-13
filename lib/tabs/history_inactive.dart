import 'package:flutter/material.dart';
class Inactive extends StatelessWidget {
  const Inactive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      heightFactor: 1.5,
    child: Container(
      width: 340,
        height: 208,
        decoration: BoxDecoration(
         color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 30,
              offset: Offset(0,3),
            )
          ],
),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Row( children:[
          Text('Автомойка', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'San Fracisco'),),
          Spacer(),
          Text('PROAUTO', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'San Francisco', fontSize: 15),),
          ],),
          Padding(padding: EdgeInsets.only(top: 10)),
      Row( children:[
          Text('Аддрес', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'San Fracisco'),),
        Spacer(),
        Text('ул. Розыбакиева, 166Б', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'San Francisco', fontSize: 15),),
      ],),
      Padding(padding: EdgeInsets.only(top: 10)),
      Row( children:[
          Text('День брони',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'San Fracisco'),),
        Spacer(),
        Text('11.03.2023', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'San Francisco', fontSize: 15),),
      ],),
          Padding(padding: EdgeInsets.only(top: 10)),
      Row( children:[
          Text('Время брони',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'San Fracisco'),),
        Spacer(),
        Text('14:22', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'San Francisco', fontSize: 15),),
      ],),
          Padding(padding: EdgeInsets.only(top: 10)),

          Divider(
height: 10,color: Colors.black.withOpacity(0.5),
         ),
          Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
              width: 136,
              height: 35,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color.fromRGBO(145, 122, 253, 1),
                        Color.fromRGBO(98, 78, 234, 1)
                      ]),
                ),
                child: Material(
                  elevation: 5,
                  color: Colors.transparent,
                  child: MaterialButton(
                    child: Text(
                      "Выйти",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                    onPressed: ()  {

                    },
                  ),
                ),
              ))

        ],
      ),),
            ),
    ),
    );
  }
}
