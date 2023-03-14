import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/car_wash_detail.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late final ap = Provider.of<AuthProvider>(context, listen: false);

  List<bool> favourites = [];

  Future getFavourites() async {
    await ap.getFavourites();
    setState(() {
      favourites = ap.favourites;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Избранное'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: favourites.length,
          itemBuilder: (BuildContext context, int index) {
            if (favourites[index]) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CarWashDetail(carWash: ap.carWashes[index])))
                      .then((_) {
                    setState(() {});
                  });
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ap.carWashes[index].name,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(ap.carWashes[index].address),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox(
                height: 0,
              );
            }
          }),
    );
  }
}
