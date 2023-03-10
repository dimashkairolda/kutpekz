import 'package:flutter/material.dart';
import 'package:kutpekz/tabs/history_active.dart';
import 'package:kutpekz/tabs/history_inactive.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('История'),
          toolbarHeight: 100  ,
          backgroundColor: Colors.transparent, elevation: 0,
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading:
          Container(height: 100.0,
            width: 100.0,
            margin: EdgeInsets.only(left: 10),
            child: FittedBox(
              child: FloatingActionButton( onPressed: () {
              },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.chevron_left, size: 30, color: Colors.black,),
                backgroundColor: Colors.white,),
            ),
          ),

        ),
        body:
        Column(
          children: [
            TabBar(tabs: [
              Tab(child: Text('Активный', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),),),
              Tab(child: Text('Завершен', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),),),
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
