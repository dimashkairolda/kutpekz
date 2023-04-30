import 'dart:async';
import 'dart:typed_data';

import 'package:dgis_flutter/dgis_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
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
  Position currentPosition = Position(longitude: 76.897746, latitude: 43.234571, timestamp: DateTime.now(), accuracy: 0, altitude: 180, heading: 0, speed: 0, speedAccuracy: 0);
  final GisMapController controller = GisMapController();
  List<GisMapMarker> list = [];
  List<GisMapMarker> tempList = [];
  late AuthProvider ap;
  Uint8List? icon;

  @override
  void initState() {
    ap = Provider.of<AuthProvider>(context, listen: false);
    getMarkers();
    _getCurrentLocation();

    // StreamSubscription positionStream =
    //     Geolocator.getPositionStream(locationSettings: const LocationSettings())
    //         .listen((Position position) {
    //   setState(() {
    //     currentPosition = position;
    //   });
    // });

    super.initState();
  }

  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      if(!mounted) return;
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future setIcon() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/kutpe-kz.appspot.com/o/marker%2Fpin_drop.png?alt=media&token=1beb06ad-18dc-409b-a835-61acbe426524'),
    );
    icon = response.bodyBytes;
  }

  Future<void> getMarkers() async {
    if (list.isNotEmpty) {
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

    list = markers;
    if(!mounted) return;
    setState(() {
      controller.updateMarkers(list!);
    });
  }

  Future setMarkers() async {
    if(!mounted) return;
    setState(() {
      controller.init();
      controller.updateMarkers(list!);
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
            final c = ap.carWashes[int.parse(marker.id)];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CarWashDetail(
                  carWash: c,
                ),
              ),
            );
          },
          startCameraPosition: GisCameraPosition(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude,
            bearing: 0,
            tilt: 0,
            zoom: 15,
          ),
        ),
      ),
    );
  }
}
