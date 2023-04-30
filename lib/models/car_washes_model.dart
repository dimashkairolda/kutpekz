
class CarWashes{
  String name;
  String address;
  List<String> photoURL;
  String uid;
  String latitude;
  String longitude;
  String phoneNumber;
  String weekEndHours;
  String weekDayHours;

  String get getName => name;
  String get getAddress => address;
  List<String> get getPhotoURL => photoURL;

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
    });

  factory CarWashes.fromMap(Map<String, dynamic> map){
    return CarWashes(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      photoURL: List<String>.from(map['photoURL']),
      uid: map['uid'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      weekDayHours: map['weekDayHours'] ?? '',
      weekEndHours: map['weekEndHours'] ?? '',
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