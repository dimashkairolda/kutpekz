import 'package:kutpekz/models/times_model.dart';

class CarWashes{
  String name;
  String address;
  String photoURL;
  String uid;
  String latitude;
  String longitude;
  String phoneNumber;
  String weekEndHours;
  String weekDayHours;
  TimesModel times;

  String get getName => name;
  String get getAddress => address;
  String get getPhotoURL => photoURL;
  TimesModel get getTimeModel => times;

  CarWashes({
    required this.name,
    required this.address,
    required this.photoURL,
    required this.uid,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.weekDayHours,
    required this.weekEndHours,
    required this.times,
    });

  factory CarWashes.fromMap(Map<String, dynamic> map){
    return CarWashes(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      photoURL: map['photoURL'] ?? '',
      uid: map['uid'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      weekDayHours: map['weekDayHours'] ?? '',
      weekEndHours: map['weekEndHours'] ?? '',
      times: map['times'] ?? '',
    );
  }

  // to Map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "photoURL": photoURL,
      "uid": uid,
      "latitude": latitude,
      "longitude": longitude,
      "phoneNumber": phoneNumber,
      "weekEndHours": weekEndHours,
      "weekDayHours": weekDayHours,
    };
  }

}

class TimeModel {

}