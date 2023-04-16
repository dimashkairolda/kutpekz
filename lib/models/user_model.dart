
class UserModel{
  String phoneNumber;
  String name;
  String profilePicture;
  String createdAt;
  String uid;
  List<bool> isFavourite;
  List<String> bookings;

  UserModel({
    required this.phoneNumber,
    required this.name,
    required this.profilePicture,
    required this.createdAt,
    required this.uid,
    required this.isFavourite,
    required this.bookings,
  });



  // from Map
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
        phoneNumber: map['phoneNumber'] ?? '',
        name: map['name'] ?? '',
        profilePicture: map['profilePicture'] ?? '',
        createdAt: map['createdAt'] ?? '',
        uid: map['uid'] ?? '',
        isFavourite: List<bool>.from(map['isFavourite']),
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
      "isFavourite" : isFavourite,
      "bookings" : bookings,
    };
  }

  void setFavourites(List<bool> favourites){
    isFavourite = favourites;
  }
}