import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 10, minute: 0);
  late TimeOfDay bookedTime;
  DateTimeRange range = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 14)));

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите дату'),
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
              heroTag: UniqueKey(),
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
          children: [
            CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 14)),
                onDateChanged: (date) {
                  setState(() {
                    ap.setBookedDate(date);
                    print("Picked Date: $date");
                    _dateTime = date;
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
                    onPressed: () async {
                      TimeRange selectedTime = await showTimeRangePicker(
                          context: context,
                          start: TimeOfDay(hour: 10, minute: 00),
                          disabledTime: TimeRange(
                              startTime: TimeOfDay(hour: 24, minute: 00),
                              endTime: TimeOfDay(hour: 9, minute: 59)),
                          interval: Duration(minutes: 30),
                      maxDuration: Duration(hours: 1, minutes: 30));
                      setState(() {
                        ap.setBookedTime(selectedTime);
                      });
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
