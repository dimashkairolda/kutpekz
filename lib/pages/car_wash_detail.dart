import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/car_washes_model.dart';
import 'package:provider/provider.dart';

class CarWashDetail extends StatefulWidget {
  final CarWashes carWash;
  const CarWashDetail({Key? key, required this.carWash,}) : super(key: key);

  @override
  State<CarWashDetail> createState() => _CarWashDetail();

  Icon getIcon(bool isFavourite){
    return isFavourite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border);
  }
}

class _CarWashDetail extends State<CarWashDetail> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    int id = int.parse(widget.carWash.uid);
    bool isFavourite = ap.favourites[id];
    Icon icon =  isFavourite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border);
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.carWash.getName),
          actions: [
            IconButton(
              icon: icon,
              onPressed: () {
                setState(() {
                  print(ap.favourites.length);
                  isFavourite = !isFavourite;
                  ap.favourites[id] = isFavourite;
                  ap.updateFavourites(context);
                  icon =  isFavourite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border);
                });
              },
            ),
          ]
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Card(

            ),
          ),
          const SizedBox(
            height: 300,
            child: Image(
              image: AssetImage('assets/12.png'),
            ),
          ),
          ListTile(
            title: Text(widget.carWash.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
            subtitle: Text(widget.carWash.getAddress, style: const TextStyle(fontSize: 16),),
          ),
          Text(widget.carWash.address),
        ],
      ),
    );
  }

}
