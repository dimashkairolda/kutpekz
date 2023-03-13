import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    print("Length ${ap.favourtites.length}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Избранное'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: ap.favourtites.length,
        itemBuilder: (BuildContext context, int index) {
          if(ap.favourtites[index]){
            return Card(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(ap.carWashes[index].name, style: TextStyle(fontSize: 20,),),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(ap.carWashes[index].address),
                  ),
                ],
              ),
            );
          }
          else{
            return SizedBox(height: 0,);
          }
        }
      ),
    );
  }
}
