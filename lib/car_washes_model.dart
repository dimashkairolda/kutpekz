class CarWashes{
  String name;
  String address;
  String photoURL;
  String uid;

  CarWashes({
    required this.name,
    required this.address,
    required this.photoURL,
    required this.uid,
    });

  factory CarWashes.fromMap(Map<String, dynamic> map){
    return CarWashes(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      photoURL: map['photoURL'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  // to Map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "photoURL": photoURL,
      "uid": uid,
    };
  }

}