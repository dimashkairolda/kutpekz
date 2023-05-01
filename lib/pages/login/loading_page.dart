import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/bottom_nav/home_page.dart';
import 'package:kutpekz/pages/login/signup_page.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late final ap = Provider.of<AuthProvider>(context, listen: true);
  bool isLoading = false;
  late Widget page;

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'ru_Ru';
  }

  Future loadData() async {
    if (isLoading) return;
    isLoading = true;
    ap.getDataFromStorage();
    await ap.saveUserDataPreferences();
  }
  
  Future<bool> isSignedIn() async {
    return ap.isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([isSignedIn(), loadData()]),
      builder: (context, snapshot){
        if(ap.isSignedIn){
          return const HomeScreen();
        }
        else{
          return const SignUp();
        }
      }
    );
  }
}
