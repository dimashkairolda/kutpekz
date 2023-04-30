
class UserModel{
  String phoneNumber;
  String name;
  String profilePicture;
  String createdAt;
  String uid;
  List<String> favorites;
  List<String> bookings;

  UserModel({
    required this.phoneNumber,
    required this.name,
    required this.profilePicture,
    required this.createdAt,
    required this.uid,
    required this.favorites,
    required this.bookings,
  });



  // from Map
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
        phoneNumber: map['phoneNumber'] ?? '',
        name: map['name'] ?? '',
        favorites: List<String>.from(map['favorites'] ?? []),
        profilePicture: map['profilePicture'] ?? '',
        createdAt: map['createdAt'] ?? '',
        uid: map['uid'] ?? '',
        bookings: List<String>.from(map['bookings'] ?? []),
    );
  }

  // to Map
  Map<String, dynamic> toMap() {
    return {
      "phoneNumber": phoneNumber,
      "name": name,
      "profilePicture": profilePicture,
      "createdAt": createdAt,
      "uid": uid,
      "favorites" : favorites,
      "bookings" : bookings,
    };
  }
}