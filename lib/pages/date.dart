import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/car_washes_model.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';

class DatePicker extends StatefulWidget {
  CarWashes carWash;
  DatePicker({Key? key, required this.carWash}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime dateTime = DateTime.now();
  DateTime today = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 10, minute: 0);
  bool dateSelected = false;
  Map<String,bool> times = {};
  late TimeOfDay bookedTime;
  int dateIndex = 0;
  DateTimeRange range = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(Duration(days: 14)));
  List<bool> selected = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    times = widget.carWash.times.times[0];
    selected = List.generate(20, (i) => false);
  }

  @override
  Widget build(BuildContext context) {
    today = today.subtract(Duration(hours: today.hour, minutes: today.minute, seconds: today.second, milliseconds:  today.millisecond, microseconds: today.microsecond));
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 14)),
                  onDateChanged: (date) {
                    setState(() {
                      dateSelected = true;
                      selected = List.generate(20, (i) => false);
                      dateIndex = date.difference(today).inDays;
                      times = widget.carWash.times.times[dateIndex];
                      dateTime = date;
                      ap.setBookedDate(dateTime);
                      print(times);
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                          clipBehavior: Clip.hardEdge,
                          scrollDirection: Axis.horizontal,
                          itemCount: times.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              width: 120,
                              child: ListTile(
                                  tileColor: selected[index] ? Theme.of(context).colorScheme.primary.withOpacity(0.5) : Theme.of(context).scaffoldBackgroundColor,
                                  onTap: (){
                                    setState(() {
                                      selected[index] = !selected[index];
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  title: Align(
                                    alignment: FractionalOffset.topCenter,
                                    child: Text(
                                      times.keys.elementAt(index),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  )
                              ),
                            );
                          }),
                    ),
                  )
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                          'Ваше бронирование было успешно выполнено'),
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
