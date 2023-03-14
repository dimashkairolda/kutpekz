import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/car_washes_model.dart';
import 'package:kutpekz/pages/car_wash_detail.dart';
import 'package:kutpekz/pages/map_page.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);


  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isSearching = false;
  String searchQuery = "";
  TextEditingController _searchQueryController = TextEditingController();
  List<CarWashes> carWashes = [];
  List<CarWashes> output = [];
  late final ap = Provider.of<AuthProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    ap.getCarWashesFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Kutpe-Kz', style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search, color: Colors.black,)),
        ],
      ),
      body: MapPage(),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {

  List<String> search = [];
  List<CarWashes> carWashes = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.black,),
        onPressed: () {
          query = '';
        },
      ),

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    },
        icon: const Icon(Icons.arrow_back, color: Colors.black,));
  }

  @override
  Widget buildResults(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    search = ap.carWashNames;
    carWashes = ap.carWashes;

    List<String> matchQuery = [];
    for(var item in search){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = carWashes[index];
          return Container(
              color: Colors.white,
              // padding: EdgeInsets.fromLTRB(25, 16, 0, 0),
              child: TextButton(
                style: ButtonStyle(alignment: Alignment.centerLeft),
                child: Text(result.name, style: TextStyle(fontSize: 16),),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      CarWashDetail(carWash: result,)));
                },
              )
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    search = ap.carWashNames;
    carWashes = ap.carWashes;
    List<String> matchQuery = [];
    for(var item in search){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = carWashes[index];
          return Container(
              color: Colors.white,
              // padding: EdgeInsets.fromLTRB(25, 16, 0, 0),
              child: TextButton(
                style: ButtonStyle(alignment: Alignment.centerLeft),
                child: Text(result.name, style: TextStyle(fontSize: 16),),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      CarWashDetail(carWash: result,)));
                },
              )
          );
        }
    );
  }

}