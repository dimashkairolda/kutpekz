import 'package:kutpekz/models/history_model.dart';

class UserModel{
  String phoneNumber;
  String email;
  String name;
  String profilePicture;
  String createdAt;
  String uid;
  List<bool> isFavourite;
  HistoryModel history;
  List<String> bookings;

  UserModel({
    required this.phoneNumber,
    required this.email,
    required this.name,
    required this.profilePicture,
    required this.createdAt,
    required this.uid,
    required this.isFavourite,
    required this.history,
    required this.bookings,
  });



  // from Map
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
        phoneNumber: map['phoneNumber'] ?? '',
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        profilePicture: map['profilePicture'] ?? '',
        createdAt: map['createdAt'] ?? '',
        uid: map['uid'] ?? '',
        isFavourite: List<bool>.from(map['isFavourite']),
        history: HistoryModel.fromMap(map['history']),
        bookings: List<String>.from(map['bookings'] ?? []),
    );
  }

  // to Map
  Map<String, dynamic> toMap() {
    return {
      "phoneNumber": phoneNumber,
      "email": email,
      "name": name,
      "profilePicture": profilePicture,
      "createdAt": createdAt,
      "uid": uid,
      "isFavourite" : isFavourite,
      "history" : history.toMap(),
      "bookings" : bookings,
    };
  }

  void setFavourites(List<bool> favourites){
    isFavourite = favourites;
  }
}