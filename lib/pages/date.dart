import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/models/bookingModel.dart';
import 'package:kutpekz/models/car_washes_model.dart';
import 'package:kutpekz/pages/bottom_nav/home_page.dart';
import 'package:kutpekz/utils/utils.dart';
import 'package:provider/provider.dart';

class DatePicker extends StatefulWidget {
  CarWashes carWash;
  DatePicker({Key? key, required this.carWash}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  bool isLoading = true;
  DateTime dateTime = DateTime.now();
  DateTime today = DateTime.now();
  int dateIndex = 0;
  String selectedTime = "";
  List<bool> selected = [];
  late final ap = Provider.of<AuthProvider>(context, listen: false);
  List<String> bookedTimes = [];
  List<String> availableTimes = [];
 // TODO limit to 2 bookings per 2 weeks
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBookedTimes(0);
    selected = List.generate(24, (i) => false);
  }

  Future loadBookedTimes(int index) async {
    setState(() {
      isLoading = true;
    });

    bookedTimes = await ap.getBookings(widget.carWash.name);
    availableTimes = [];
    // list of available times for a day => remove bookedTimes => show in listview
    for(int i = 9; i < 24; i++){
      if(!(index == 0 && i <= DateTime.now().hour + 7)){
        if(!bookedTimes.contains("${index},$i")){
          availableTimes.add(i.toString().padLeft(2, "0").padRight(3,":00"));
        }
      }
    }
    setState(() {
      isLoading = false;
    });
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
                  currentDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 14)),
                  onDateChanged: (date) {
                    setState(() {
                      selected = List.generate(20, (i) => false);
                      dateIndex = date.difference(today).inDays;
                      dateTime = date;
                      ap.setBookedDate(dateTime);
                      loadBookedTimes(dateIndex);
                      });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Доступное время",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  const SizedBox(height: 8,),
                  isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 45,
                      child: ListView.builder(
                        shrinkWrap: true,
                          clipBehavior: Clip.hardEdge,
                          scrollDirection: Axis.horizontal,
                          itemCount: availableTimes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if(!selected[index]){
                                    selected.replaceRange(0, selected.length, selected.map((element) => false));
                                    selectedTime = availableTimes[index];
                                  }
                                  else{
                                    selectedTime = "";
                                  }
                                  selected[index] = !selected[index];
                                });
                              },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 6),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 6
                                  ),
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: selected[index] ? Theme.of(context).colorScheme.primary.withOpacity(0.5) : Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                                    border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                                  ),

                                  child: Center(
                                    child: Text(
                                      availableTimes[index],
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
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
                color: const Color.fromRGBO(98, 78, 234, 1),
                borderRadius: BorderRadius.circular(10),
                child: const Text(
                  "Забронировать",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
                onPressed: () async {
                  DateTime bookingStart = today.add(Duration(days: dateIndex, hours: int.parse(selectedTime.substring(0,2)) - 6));
                  if(dateIndex == 0 && bookingStart.hour <= DateTime.now().hour + 6){
                    showSnackBar(context, "Ошибка");
                    return;
                  }

                  print(bookingStart.timeZoneOffset);
                  print(bookingStart);
                  ap.addBooking(BookingModel(
                    bookingStart: bookingStart,
                    bookingEnd: bookingStart.add(Duration(hours: 1)),
                    bookedTime: DateTime.now(),
                    phoneNumber: ap.userModel.phoneNumber,
                    userName: ap.userModel.name,
                    userId: ap.userModel.uid,
                    washName: widget.carWash.name,
                    address: widget.carWash.address
                  ));

                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                          'Ваше бронирование было успешно выполнено'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
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
