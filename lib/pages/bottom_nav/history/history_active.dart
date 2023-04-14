import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:provider/provider.dart';

class Active extends StatelessWidget {
  const Active({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ap.bookedTime == null
              ? Column(
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
              : Center(
                  heightFactor: 1.5,
                  child: Container(
                    width: 340,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
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
                                ap.bookedCarWashName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
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
                                ap.bookedCarWashAddress,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
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
                                "${ap.bookedDate.day.toString().padLeft(2, '0')}.${ap.bookedDate.month.toString().padLeft(2, '0')}.${ap.bookedDate.year}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
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
                                "${ap.bookedTime}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
