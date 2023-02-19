class UserModel{
  String phoneNumber;
  String email;
  String name;
  String profilePicture;
  String createdAt;
  String uid;
  String password;

  UserModel({
    required this.phoneNumber,
    required this.email,
    required this.name,
    required this.profilePicture,
    required this.createdAt,
    required this.uid,
    required this.password
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
        password: map['password'] ?? '',
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
      "password" : password,
    };
  }
}