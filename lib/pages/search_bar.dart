import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/car_washes_model.dart';
import 'package:kutpekz/pages/car_wash_detail.dart';
import 'package:kutpekz/pages/map_page.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
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
    // TODO: implement initState
    getCarWashNames();
    ap.getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: _buildSearchField(),
        actions: _buildActions(),
      ),
      body: Stack(
        children: [
          const MapPage(),
          if(_isSearching) _buildList(),
        ],
      ),
    );
  }
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: false,
      decoration: const InputDecoration(
        hintText: "Поиск...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
      onSubmitted: (query){_stopSearching();} ,
      onTap: (){_startSearch();},
      // onTapOutside: (query){_stopSearching();},
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        color: Colors.black,
        onPressed: (){}
      ),
    ];
  }

  Widget _buildList() {

    return ListView.builder(
      itemCount: output.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          // padding: EdgeInsets.fromLTRB(25, 16, 0, 0),
          child: TextButton(
            style: ButtonStyle(alignment: Alignment.centerLeft),
            child: Text(output[index].getName, style: TextStyle(fontSize: 16),),
            onPressed: () {
              CarWashes c = output[index];
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  CarWashDetail(carWash: c,)));
              _stopSearching();
            },
          )
        );
      },
    );
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;

      output.clear();
      for(CarWashes carWash in carWashes){
        if(searchQuery != '' && carWash.getName.contains(RegExp(searchQuery, caseSensitive: false))){
          output.add(carWash);
        }
      }
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  Future getCarWashNames() async {
    ap.getCarWashesFromStorage();
    carWashes = ap.carWashes;
    for(CarWashes carWash in carWashes){
      print("search bar getCarWashNames()");
      print(carWash.toMap().toString());
    }
  }
}
