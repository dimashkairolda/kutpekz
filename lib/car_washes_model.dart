class CarWashes{
  String name;
  String address;
  String photoURL;
  String uid;
  String latitude;
  String longitude;

  String get getName => name;
  String get getAddress => address;
  String get getPhotoURL => photoURL;

  CarWashes({
    required this.name,
    required this.address,
    required this.photoURL,
    required this.uid,
    required this.latitude,
    required this.longitude,
    });

  factory CarWashes.fromMap(Map<String, dynamic> map){
    return CarWashes(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      photoURL: map['photoURL'] ?? '',
      uid: map['uid'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
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
    };
  }

}