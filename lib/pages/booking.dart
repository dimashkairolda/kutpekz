import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

// TODO - CLICK TILES

class _BookingState extends State<Booking> {
  bool _checkbox = false;
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сервисы'),
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: Container(
          height: 100.0,
          width: 100.0,
          margin: const EdgeInsets.only(left: 10),
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
              ),
            ),
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
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(
                        () {
                          _checkbox = !_checkbox;
                        },
                      );
                    },
                  ),
                  const Text('Мойка машин'),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 30,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _checkbox1,
                    onChanged: (value) {
                      setState(
                        () {
                          _checkbox1 = !_checkbox1;
                        },
                      );
                    },
                  ),
                  const Text('Химчистка автомобилей'),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 30,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _checkbox2,
                    onChanged: (value) {
                      setState(
                        () {
                          _checkbox2 = !_checkbox2;
                        },
                      );
                    },
                  ),
                  const Text('Мойка двигателя'),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 30,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _checkbox3,
                    onChanged: (value) {
                      setState(
                        () {
                          _checkbox3 = !_checkbox3;
                        },
                      );
                    },
                  ),
                  const Text('Автомойка самообслуживания'),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              width: 365,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color.fromRGBO(145, 122, 253, 1),
                      Color.fromRGBO(98, 78, 234, 1)
                    ],
                  ),
                ),
                child: Material(
                  elevation: 5,
                  color: Colors.transparent,
                  child: MaterialButton(
                    child: const Text(
                      "Забронировать",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/datepicker');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
