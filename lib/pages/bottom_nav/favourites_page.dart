import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/generated/locale_keys.g.dart';
import 'package:kutpekz/pages/car_wash_detail.dart';
import 'package:provider/provider.dart';


class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late final ap = Provider.of<AuthProvider>(context, listen: false);
  bool isLoading = false;

  List<bool> favourites = [];

  Future getFavourites() async {
    isLoading = true;
    await ap.getFavourites();
    if(!mounted) return;
    setState(() {
      favourites = ap.favourites;
      isLoading = false;
      print(favourites.isEmpty);
    });
  }

  @override
  void initState() {
    super.initState();
    getFavourites();
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
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: favourites.isEmpty
          ? Scaffold(
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isLoading ? [CircularProgressIndicator()] : [
                      Image.asset(
                        'assets/Empty_box.png',
                        width: 340,
                        height: 267,
                      ),
                      const Text(
                        'У вас нет избранных автомоек',
                        style: TextStyle(
                            fontFamily: 'San Francisco',
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : ListView.builder(
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
                            setState(() {

                            });
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
