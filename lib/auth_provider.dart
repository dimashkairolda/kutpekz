import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgis_flutter/dgis_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_to_byte/image_to_byte.dart';
import 'package:kutpekz/car_washes_model.dart';
import 'package:kutpekz/home_page.dart';
import 'package:kutpekz/otp_page.dart';
import 'package:kutpekz/user_model.dart';
import 'package:kutpekz/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _uid;

  String get uid => _uid!;

  PhoneAuthCredential? credential;

  UserModel? _userModel;

  UserModel get userModel => _userModel!;

  List<CarWashes> _carWashes = List.from([], growable: true);

  List<CarWashes> get carWashes => _carWashes;

  List<String> _carWashNames = [];

  List<String> get carWashNames => _carWashNames;

  List<GisMapMarker> _carWashMarkers = [];

  List<GisMapMarker> get carWashMarkers => _carWashMarkers;

  final GisMapController _controller = GisMapController();

  GisMapController get controller => _controller;

  List<bool> _favourites = [];

  List<bool> get favourites => _favourites;

  late CachedNetworkImageProvider pfp;


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSignIn();
    _controller.updateMarkers(_carWashMarkers);
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    if (_isSignedIn) {
      getUserDataFromPreferences();
    }
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpPage(
                        verificationId: verificationId,
                        phoneNumber: phoneNumber,
                        isChange: false,
                      )),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void getCredentials(BuildContext context, String verificationId, String userOtp){
    credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp);
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // create user using credentials
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(credential)).user;

      if (user != null) {
        // store user
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future userSignOut() async {
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  Future<bool> checkExistingUsers() async {
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("User Exists");
      return true;
    } else {
      print("New User");
      return false;
    }
  }

  void saveUserData({
    required BuildContext context,
    required UserModel userModel,
    required File profilePicture,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // upload image
      await storeFileToStorage("profilePicture/$_uid", profilePicture)
          .then((value) {
        userModel.profilePicture = value;
        userModel.createdAt = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.uid;
      });
      _userModel = userModel;
      // upload usermodel to database

      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future getDataFromStorage() async {
    await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) async {
          List<bool> b = [];
          for(int i = 0; i < carWashes.length; i++){
            b.add(false);
          }

      _userModel = UserModel(
        phoneNumber: snapshot['phoneNumber'],
        email: snapshot['email'],
        name: snapshot['name'],
        profilePicture: snapshot['profilePicture'],
        createdAt: snapshot['createdAt'],
        uid: snapshot['uid'],
        isFavourite: b,
      );
      b.clear();
      _uid = userModel.uid;
    });
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future saveUserDataPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getUserDataFromPreferences() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String data = sp.getString("user_model") ?? '';
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid = _userModel!.uid;
    pfp = CachedNetworkImageProvider(userModel.profilePicture);
    notifyListeners();
  }

  Future<void> getCarWashesFromStorage() async {
      _carWashes = [];
      _carWashNames = [];
      var snapshot = await _firebaseFirestore.collection('car-washes').get();
      for (var item in snapshot.docs) {
        CarWashes c = CarWashes(
          name: item['name'],
          address: item['address'],
          photoURL: item['photoURL'],
          uid: item['uid'],
          latitude: item['latitude'],
          longitude: item['longitude'],
          phoneNumber: item['phoneNumber'],
          weekEndHours: item['weekEndHours'],
          weekDayHours: item['weekDayHours'],
        );
        _carWashNames.add(c.name);
        _carWashes.add(c);
      }
    }

  Future<void> updateName(BuildContext context, String name) async {
    _userModel?.name = name;

    try {
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap());

      _isLoading = false;
      Navigator.pop(context);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  String? getPhoneNumber() {
    String? phone = _userModel?.phoneNumber;
    return phone;
  }

  Future<bool> phoneNumberExists(String phoneNumber) async {
    String user = '';
    var snapshot = await _firebaseFirestore.collection('users').get();
    for (var item in snapshot.docs) {
      user = item['uid'];
      if (item['phoneNumber'] == phoneNumber && user != uid)  return true;
    }
    return false;
  }

  Future<String?> getName() async {
    String name = '';
    await _firebaseFirestore.collection('users').doc(_uid).get().then((value) {
      name = value['name'];
      userModel.name = name;
    });
    return name;
  }

  String? getCurrentName() {
    return userModel.name;
  }

  Future getFavourites() async {
    favourites.clear();
    await _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) async {
      List<bool> b = List<bool>.from(snapshot['isFavourite'], growable: true);
      userModel.setFavourites(b);
      _favourites = (userModel.isFavourite);
    });
  }

  Future updateFavourites(BuildContext context) async {
    userModel.isFavourite = favourites;

    try {
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap());

      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
}
