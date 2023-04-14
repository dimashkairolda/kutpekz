import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kutpekz/models/car_washes_model.dart';
import 'booking_calendar.dart';

import 'date.dart';

class Booking extends StatefulWidget {
  CarWashes carWash;
  Booking({Key? key, required this.carWash}) : super(key: key);

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
              child: const Icon(
                Iconsax.arrow_left_2,
                size: 30,
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
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CheckboxListTile(
                // activeColor: Colors.white,
                checkColor: Colors.grey.shade900,
                controlAffinity: ListTileControlAffinity.leading,
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      _checkbox = !_checkbox;
                    },
                  );
                },
                value: _checkbox,
                title: Text('Мойка машин'),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CheckboxListTile(
                // activeColor: Colors.white,
                checkColor: Colors.grey.shade900,
                value: _checkbox1,
                controlAffinity: ListTileControlAffinity.leading,
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      _checkbox1 = !_checkbox1;
                    },
                  );
                },
                title: Text('Химчистка автомобилей'),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CheckboxListTile(
                // activeColor: Colors.white,
                checkColor: Colors.grey.shade900,
                value: _checkbox2,
                controlAffinity: ListTileControlAffinity.leading,
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      _checkbox2 = !_checkbox2;
                    },
                  );
                },
                title: const Text('Мойка двигателя'),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CheckboxListTile(
                // activeColor: Colors.white,
                checkColor: Colors.grey.shade900,
                value: _checkbox3,
                controlAffinity: ListTileControlAffinity.leading,
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      _checkbox3 = !_checkbox3;
                    },
                  );
                },
                title: const Text('Автомойка самообслуживания'),
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: CupertinoButton(
                    color: Color.fromRGBO(98, 78, 234, 1),
                    borderRadius: BorderRadius.circular(10),
                    child: const Text(
                      "Забронировать",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Booking(carWash: widget.carWash)));
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => DatePicker(carWash: widget.carWash,)));
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
