// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:booking_calendar/booking_calendar.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kutpekz/models/bookingModel.dart';
//
// class BookingCalendarDemo extends StatefulWidget {
//   const BookingCalendarDemo({Key? key}) : super(key: key);
//
//   @override
//   State<BookingCalendarDemo> createState() => _BookingCalendarDemoState();
// }
//
// class _BookingCalendarDemoState extends State<BookingCalendarDemo> {
//   final now = DateTime.now();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   CollectionReference bookings = FirebaseFirestore.instance.collection('bookings');
//
//   ///This is how can you get the reference to your data from the collection, and serialize the data with the help of the Firestore [withConverter]. This function would be in your repository.
//   CollectionReference<BookingModel> getBookingStream({required String placeId}) {
//     return bookings.doc(placeId).collection('bookings').withConverter<BookingModel>(
//       fromFirestore: (snapshots, _) => BookingModel.fromJson(snapshots.data()!),
//       toFirestore: (snapshots, _) => snapshots.toJson(),
//     );
//   }
//
//   ///How you actually get the stream of data from Firestore with the help of the previous function
//   ///note that this query filters are for my data structure, you need to adjust it to your solution.
//   Stream<dynamic>? getBookingStreamFirebase(
//       {required DateTime end, required DateTime start}) {
//     return getBookingStream(placeId: 'YOUR_DOC_ID')
//         .where('bookingStart', isGreaterThanOrEqualTo: start)
//         .where('bookingStart', isLessThanOrEqualTo: end)
//     .snapshots();
//   }
//
//   ///After you fetched the data from firestore, we only need to have a list of datetimes from the bookings:
//   List<DateTimeRange> convertStreamResultFirebase(
//       {required dynamic streamResult}) {
//     ///here you can parse the streamresult and convert to [List<DateTimeRange>]
//     ///Note that this is dynamic, so you need to know what properties are available on your result, in our case the [SportBooking] has bookingStart and bookingEnd property
//     List<DateTimeRange> converted = [];
//     for (var i = 0; i < streamResult.size; i++) {
//       final item = streamResult.docs[i].data();
//       converted.add(DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
//     }
//     return converted;
//   }
//
//   ///This is how you upload data to Firestore
//   Future<dynamic> uploadBookingFirebase(
//       {required BookingService newBooking}) async {
//     await bookings
//         .doc()
//         .collection('bookings')
//         .add(newBooking.toJson())
//         .then((value) => print("Booking Added"))
//         .catchError((error) => print("Failed to add booking: $error"));
//   }
//
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Забронировайте автомойку'),
//         toolbarHeight: 100,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         leading: Container(
//           height: 100.0,
//           width: 100.0,
//           margin: const EdgeInsets.only(left: 10),
//           child: FittedBox(
//             child: FloatingActionButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               heroTag: UniqueKey(),
//               child: const Icon(
//                 Iconsax.arrow_left_2,
//                 size: 30,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Center(
//         child: BookingCalendar(
//           height: 65,
//           availableSlotTextStyle: TextStyle(fontSize: 16),
//           availableSlotColor: Theme.of(context).colorScheme.primary,
//           bookingButtonColor: Theme.of(context).colorScheme.primary,
//           bookingButtonText: "Забронировать",
//           availableSlotText: "Доступно",
//           bookedSlotText: "Забронировано",
//           selectedSlotText: "Выбрано",
//           bookingService: mockBookingService,
//           convertStreamResultToDateTimeRanges: convertStreamResultFirebase,
//           getBookingStream: getBookingStreamFirebase,
//           uploadBooking: uploadBookingFirebase,
//           hideBreakTime: true,
//           loadingWidget: const Text('Получаем данные...'),
//           uploadingWidget: const CircularProgressIndicator(),
//           startingDayOfWeek: StartingDayOfWeek.monday,
//           wholeDayIsBookedWidget:
//           const Text('На этот день все забронировано'),
//         ),
//       ),
//     );
//   }
// }
