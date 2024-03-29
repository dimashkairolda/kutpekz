import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/generated/locale_keys.g.dart';
import 'package:kutpekz/models/car_washes_model.dart';
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
  List<String> favourites = [];

  Future getFavourites() async {
    isLoading = true;
    favourites = [];
    if(!mounted) return;
    setState(() {
      favourites = ap.userModel.favorites;
      isLoading = false;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: isLoading ? [const Center(child: Padding(padding: EdgeInsets.only(bottom: 100), child: CircularProgressIndicator()),)] : [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarWashDetail(
                                        carWash: ap.carWashes[int.parse(favourites[index])],
                                      ))).then((_) {
                            setState(() {

                            });
                          });
                        },
                        title: Text(
                          ap.carWashes[int.parse(favourites[index])].name,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(ap.carWashes[int.parse(favourites[index])].address),
                      ),
                    ),
                  );
              },),
    );
  }
}
