import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/models/car_washes_model.dart';
import 'package:kutpekz/generated/locale_keys.g.dart';
import 'package:kutpekz/pages/bottom_nav/map/map_page.dart';
import 'package:kutpekz/pages/car_wash_detail.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final ap = Provider.of<AuthProvider>(context, listen: false);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.transparent, elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Kutpe-Kz',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate(hintText: LocaleKeys.search_hint.tr()));
              },
              icon: const Icon(
                Iconsax.search_normal,
              )),
        ],
      ),
      body: MapPage(),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  String hintText;


  CustomSearchDelegate({
    required this.hintText,
    })
      : super(
          searchFieldLabel: hintText,
        );

  List<String> search = [];
  List<CarWashes> carWashes = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Iconsax.close_circle,
          size: 27,
        ),
        onPressed: () {
          if(query == '') close(context, "");
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Iconsax.arrow_left_2,
        ),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    search = ap.carWashNames;
    carWashes = ap.carWashes;
    List<CarWashes> result = [];
    List<String> matchQuery = [];
    for (var item in search) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    for(var carWash in carWashes){
      if(matchQuery.contains(carWash.name)){
        result.add(carWash);
      }
    }

    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: matchQuery.length == 0 ? Text("По запросу: \"$query\", автомоек не найдено", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),) :ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var item = result[index];
          return Container(
            // padding: EdgeInsets.fromLTRB(25, 16, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    style: const ButtonStyle(alignment: Alignment.centerLeft),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            item.address,
                            style: const TextStyle(fontSize: 12, color: Colors.white30),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CarWashDetail(
                            carWash: item,
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(height: 2,),
                ],
              )
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSuggestions(context);
  }
}
