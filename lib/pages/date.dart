import 'package:flutter/cupertino.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.outline,
              ),
              child: CalendarDatePicker(
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Доступное время",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            width: 120,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Align(
                                alignment: FractionalOffset.topCenter,
                                child: const Text(
                                  "10:00 - 11:00",
                                  style: TextStyle(fontSize: 10),
                                ),
                              )
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
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
                      title: const Text(
                          'Ваше бронирование было успешно выполнено'),
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
          ],
        ),
      ),
    );
  }
}
