import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kutpekz/pages/onboard1.dart';
import 'package:kutpekz/pages/onboard2.dart';
import 'package:kutpekz/pages/onboard3.dart';
import 'package:kutpekz/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDW8c-1dBl4vsJSGQTJkBLuyCE051d5fOY',
          appId: '1:723209621212:android:f661dc7aca04a504836e19',
          messagingSenderId: '723209621212',
          projectId: 'sdudiplomaproject',
          storageBucket: 'sdudiplomaproject.appspot.com/'
      )
  );
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.cyanAccent,
    ),
    initialRoute: '/',
    routes: {
      '/' : (context) =>onboard1(),
      '/onboard2': (context) =>onboard2(),
      '/onboard3': (context) =>onboard3(),
      '/signup': (context)=>signup(),
    },
  ),
  );
}

