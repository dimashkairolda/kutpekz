import 'package:flutter/material.dart';
class washservice extends StatelessWidget {
  const washservice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Подробно'),
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
              heroTag: UniqueKey(),
              backgroundColor: Colors.white,),
          ),
        ),
        actions: [
          Container(height: 50.0,
            width: 50.0,
            margin: EdgeInsets.only(right: 10),

            child: FittedBox(
              child: FloatingActionButton( onPressed: () {
              },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.favorite_border, size: 30, color: Colors.black,),
                heroTag: UniqueKey(),
                backgroundColor: Colors.white,),
            ),
          ),
        ],

      ),
      body:Image.asset('assets/Frame_208.png',width: 500,),
    );
  }
}
