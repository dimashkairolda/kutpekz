import 'package:flutter/material.dart';
import 'package:kutpekz/tabs/login.dart';
import 'package:kutpekz/tabs/registration.dart';

class signup extends StatelessWidget {
  const signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(112,166,255, 1.0),
          body:
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 70)),
                  TabBar(tabs: [
                    Tab(child: Text('Register', style: TextStyle(color: Colors.black, fontFamily: 'Inter'),),),
                    Tab(child: Text('Login', style: TextStyle(color: Colors.black, fontFamily: 'Inter'),),),
                  ]),
                Expanded(
                  child:
                    TabBarView(children: [
                      Register(),
                      Login(),
                    ],
                  ),
                ),
              ],
              ),
        ),
    );
  }
}

