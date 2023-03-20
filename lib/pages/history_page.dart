import 'package:flutter/material.dart';
import 'package:kutpekz/tabs/history_active.dart';
import 'package:kutpekz/tabs/history_inactive.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('История', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
          toolbarHeight: 100  ,
          backgroundColor: Colors.transparent, elevation: 0,
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body:
        Column(
          children: const [
            TabBar(tabs: [
              Tab(child: Text('Активно', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),),),
              Tab(child: Text('Завершено', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),),),
            ]),
            Expanded(
              child:
              TabBarView(children: [
                Active(),
                Inactive(),
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
