import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/models/bookingModel.dart';
import 'package:provider/provider.dart';

class Active extends StatefulWidget {
  const Active({Key? key}) : super(key: key);

  @override
  State<Active> createState() => _ActiveState();
}

class _ActiveState extends State<Active> {
  List<BookingModel> bookings = [];
  late final ap = Provider.of<AuthProvider>(context, listen: false);
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBookings();
  }

  Future loadBookings() async {
    setState(() {
      isLoading = true;
    });

    bookings.clear();
    for (String bookId in ap.userModel.bookings) {
      if(!mounted) return;
      BookingModel model =
          BookingModel.fromJson(await ap.getBookingsById(bookId));
      if (model.bookingStart.isAfter(DateTime.now())) {
        setState(() {
          bookings.add(model);
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : (bookings.isEmpty
            ? Scaffold(
                body: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/Empty_box.png',
                          width: 340,
                          height: 267,
                        ),
                        const Text(
                          'У вас нет активных бронирований',
                          style: TextStyle(
                              fontFamily: 'San Francisco',
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.only(bottom: 60),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (BuildContext context, index) {
                      return Center(
                        heightFactor: 1,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          width: 340,
                          height: 230,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Автомойка',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      bookings[index].washName!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Row(
                                  children: [
                                    const Text(
                                      'Адрес',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      bookings[index].address!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Row(
                                  children: [
                                    const Text(
                                      'День брони',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      DateFormat("dd.MM.yy")
                                          .format(ap.timeConvert(bookings[index].offset!, bookings[index].bookingStart)),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Row(
                                  children: [
                                    const Text(
                                      'Время брони',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      DateFormat("HH:mm").format(ap.timeConvert(bookings[index].offset!, bookings[index].bookingStart)),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Row(
                                  children: [
                                    const Text(
                                      'ID брони',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      bookings[index].bookId!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 10)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CupertinoButton(
                                      child: Text("Отменить бронь"),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'Вы действительно хотите отменить свое бронирование?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => ap
                                                    .removeBooking(
                                                        context,
                                                        bookings[index]
                                                            .bookId
                                                            .toString())
                                                    .then(
                                                        (_) => setState(() {
                                                          loadBookings();
                                                          Navigator.pop(context);
                                                        })),
                                                child: const Text('Да'),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Нет'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ));
  }
}
