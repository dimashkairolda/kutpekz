import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/home_page.dart';
import 'package:kutpekz/otp_page.dart';
import 'package:kutpekz/user_model.dart';
import 'package:kutpekz/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier{

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _uid;
  String get uid => _uid!;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  String? _password;
  String get password => _password!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    if(_isSignedIn) getUserDataFromPreferences();
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber, String password) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (
              PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            _password = password;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpPage(verificationId: verificationId,
                          phoneNumber: phoneNumber)
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void signInWithPhone23(BuildContext context, String phoneNumber, String password) async {
    try {
      await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
      String uid = _firebaseAuth.currentUser!.uid;
      if(await checkPassword(uid, password)){
        showSnackBar(context, 'wrong password!');
        return;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomeScreen(),
      ),
    );
  }

  void sendOtp(){

  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async{
    _isLoading = true;
    notifyListeners();

    try {
      // create user using credentials
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(credential)).user;

      if(user != null){
        // store user
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch(e) {
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
    DocumentSnapshot snapshot = await _firebaseFirestore.collection("users").doc(_uid).get();
    if(snapshot.exists){
      print("User Exists");
      return true;
    }
    print("New User");
    return false;
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
      await storeFileToStorage("profilePicture/$_uid", profilePicture).then((value) {
        userModel.profilePicture = value;
        userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.uid;
        userModel.password = _password!;
      });
      _userModel = userModel;
      // upload usermodel to database

      await _firebaseFirestore.collection("users").doc(_uid).set(userModel.toMap()).then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });

      await _firebaseFirestore.collection("RegisteredNumbers").doc(userModel.phoneNumber).set({
        "phoneNumber": FirebaseAuth.instance.currentUser!.phoneNumber,
      });

    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
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
    notifyListeners();
  }

  Future<bool> isPhoneRegistered(String phoneNumber) async {
    var snapshot = await _firebaseFirestore.collection('users').where('phoneNumber', isEqualTo: phoneNumber).get();
    if(snapshot.docs.isNotEmpty) {
      print("Phone is registered");
      return true;
    } else {
      print("Phone is not registered");
      return false;
    }
  }


  Future<bool> checkPassword(String uid, String password) async {
    var snapshot = await _firebaseFirestore.collection('users').doc(uid).get();
    if(snapshot['password'] == password){
      return true;
    }
    else {
      return false;
    }

  }
}