import 'dart:typed_data';
import 'dart:ui';

import 'package:dgis_flutter/dgis_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_to_byte/image_to_byte.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/car_wash_detail.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GisMapController controller = GisMapController();
  List<GisMapMarker>? list;
  List<GisMapMarker> tempList = [];
  late AuthProvider ap;
  Uint8List? icon;

  @override
  void initState() {
    print("Init state");
    ap = Provider.of<AuthProvider>(context, listen: false);
    getMarkers();
    super.initState();
  }

  Future setIcon() async {
    http.Response response = await http.get(
      Uri.parse('https://firebasestorage.googleapis.com/v0/b/kutpe-kz.appspot.com/o/marker%2Fpin_drop.png?alt=media&token=1beb06ad-18dc-409b-a835-61acbe426524'),
    );
    icon = response.bodyBytes;


    // if(icon != null){
    //   print("is not null");
    //   return;
    // }
    // else{
    //   print("is null");
    //   icon = await imageToByte(
    //       "https://firebasestorage.googleapis.com/v0/b/kutpe-kz.appspot.com/o/marker%2Fpin_drop.png?alt=media&token=a468c928-24e8-4abb-9042-99f3d234d45b");
    // }
  }

  Future<void> getMarkers() async {
    print("Entered getMarkers");
    if (ap.carWashMarkers.isNotEmpty) {
      print("is Not empty");
      return;
    }
    List<GisMapMarker> markers = [];
    int index = 0;
    await setIcon();

    while (index < ap.carWashes.length) {
      markers.add(GisMapMarker(
          latitude: double.parse(ap.carWashes[index].latitude),
          longitude: double.parse(ap.carWashes[index].longitude),
          icon: icon!,
          id: ap.carWashes[index].uid,
          zIndex: 1));
      index += 1;
    }
    print("Left getMarkers");
    list = markers;

    setState(() {
      print("State");
      controller.updateMarkers(list!);
    });
  }

  Future setMarkers() async {
    setState(() {
      controller.init();
      controller.updateMarkers(list!);
      // controller.updateMarkers(tempList);
    });
  }

  @override
  build(BuildContext context) {
    precacheImage(ap.pfp, context);
    // setMarkers();
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GisMap(
          directoryKey: 'ruqvec0919',
          mapKey: '5f32900c-934a-4575-8f50-c7d8f1eac2f4',
          useHybridComposition: true,
          controller: controller,
          onTapMarker: (marker) {
            // ignore: avoid_print
            final c = ap.carWashes[int.parse(marker.id)];
            Navigator.push(context, MaterialPageRoute(builder: (context) => CarWashDetail(carWash: c)));
          },
          startCameraPosition: const GisCameraPosition(
            latitude: 43.2567,
            longitude: 76.9286,
            bearing: 0,
            tilt: 0,
            zoom: 15,
          ),
        ),
      ),
    );
  }
}

class ButtonMapWidget extends StatelessWidget {
  final Widget child;
  final GisMapController controller;

  const ButtonMapWidget(
      {Key? key, required this.child, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.gps_fixed),
                  onPressed: () async {
                    final status = await controller.setCameraPosition(
                        latitude: 22, longitude: 72, bearing: 0, zoom: 12);
                  },
                  heroTag: UniqueKey(),
                ),
              ],
            )),
      ],
    );
  }
}