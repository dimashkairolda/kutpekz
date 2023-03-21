import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/generated/locale_keys.g.dart';
import 'package:provider/provider.dart';

import '../car_wash_detail.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

// TODO STYLIZE PAGE

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
    super.initState();
    getFavourites();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.btm_nav_favourites.tr(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: favourites.length,
          itemBuilder: (BuildContext context, int index) {
            if (favourites[index]) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarWashDetail(
                                carWash: ap.carWashes[index],
                              ))).then((_) {
                        setState(() {});
                      });
                    },
                    title: Text(
                      ap.carWashes[index].name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(ap.carWashes[index].address),
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
