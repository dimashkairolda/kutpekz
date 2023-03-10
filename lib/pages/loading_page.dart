import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/home_page.dart';
import 'package:kutpekz/pages/onboard_pages/onboard_page_1.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late final ap = Provider.of<AuthProvider>(context, listen: true);

  void loadData(){
    ap.getDataFromStorage();
    ap.saveUserDataPreferences();
  }

  @override
  Widget build(BuildContext context) {
    if(ap.isSignedIn){
      loadData();
      return const HomeScreen();
    }
    else {
      return const FirstOnboardPage();
    }
  }
}
