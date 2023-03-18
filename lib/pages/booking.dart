import 'package:flutter/material.dart';
class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  bool _checkbox = false;
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сервисы'),
        toolbarHeight: 100  ,
        backgroundColor: Colors.transparent, elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading:
        Container(height: 100.0,
          width: 100.0,
          margin: EdgeInsets.only(left: 10),
          child: FittedBox(
            child: FloatingActionButton( onPressed: () {
              Navigator.pop(context);
            },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.chevron_left, size: 30, color: Colors.black,),
              backgroundColor: Colors.white,),
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
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
              )
              ,child:
            Row(
              children: [
                Checkbox(
                  value: _checkbox,
                  onChanged: (value) {
                    setState(() {
                      _checkbox = !_checkbox;
                    });
                  },
                ),
                Text('Мойка машин'),
              ],
            ),),
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
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
              child:
              Row(
                children: [
                  Checkbox(
                    value: _checkbox1,
                    onChanged: (value) {
                      setState(() {
                        _checkbox1 = !_checkbox1;
                      });
                    },
                  ),
                  Text('Химчистка автомобилей'),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
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
              child:
              Row(
                children: [
                  Checkbox(
                    value: _checkbox2,
                    onChanged: (value) {
                      setState(() {
                        _checkbox2 = !_checkbox2;
                      });
                    },
                  ),
                  Text('Мойка двигателя'),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Container(
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
              child:
              Row(
                children: [
                  Checkbox(
                    value: _checkbox3,
                    onChanged: (value) {
                      setState(() {
                        _checkbox3 = !_checkbox3;
                      });
                    },
                  ),
                  Text('Автомойка самообслуживания'),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
                width: 365,
                height: 50,
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
                        "Забронировать",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      onPressed: ()  {
                        Navigator.pushNamed(context, '/datepicker');

                      },
                    ),
                  ),
                )),

          ],
        ),),

    );
  }
}
