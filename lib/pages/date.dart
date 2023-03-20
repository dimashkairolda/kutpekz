import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите дату'),
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
              heroTag: UniqueKey(),
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
            children: [
              CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(2023),
                  lastDate: DateTime.utc(2024),
                  onDateChanged: (date) {
                    setState(() {
                      _dateTime = date;
                      print(_dateTime);
                    });
                  }),
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
                          ]),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Ваше бронирование было успешно выполнено'),
                              // content: const Text(
                              //     'Ваше бронирование было успешно выполнено'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
