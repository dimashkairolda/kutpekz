import 'dart:async';
import 'dart:typed_data';

import 'package:dgis_flutter/dgis_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/car_wash_detail.dart';
import 'package:kutpekz/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position currentPosition = Position(
      longitude: 76.897746,
      latitude: 43.234571,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 180,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  final GisMapController controller = GisMapController();
  Position? pos;
  List<GisMapMarker> list = [];
  List<GisMapMarker> tempList = [];
  late AuthProvider ap;
  Uint8List? icon;
  Uint8List? posIcon;
  bool isLoading = false;

  @override
  void initState() {
    // StreamSubscription positionStream =
    //     Geolocator.getPositionStream(locationSettings: const LocationSettings())
    //         .listen((Position position) {
    //   setState(() {
    //     currentPosition = position;
    //   });
    // });
    super.initState();
    ap = Provider.of<AuthProvider>(context, listen: false);
    getMarkers();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
            forceAndroidLocationManager: true)
        .then((Position position) {
      if (!mounted) return;
      setState(() {
        pos = position;
        list.add(GisMapMarker(
            latitude: position.latitude,
            longitude: position.longitude,
            icon: posIcon!,
            id: "pos",
            zIndex: 1));
        controller.updateMarkers(list!);
      });
    }).catchError((e) {
      showSnackBar(context, e);
    });
  }

  Future setIcon() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/kutpe-kz.appspot.com/o/marker%2Fpin_drop.png?alt=media&token=1f8380c0-91d2-41fa-b5d8-b5694636d06f'),
    );
    icon = response.bodyBytes;
  }

  Future setPosIcon() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://firebasestorage.googleapis.com/v0/b/kutpe-kz.appspot.com/o/marker%2Fposition.png?alt=media&token=be210acd-6b1e-4ee9-bff8-2711d149f41a'),
    );
    posIcon = response.bodyBytes;
  }

  Future<void> getMarkers() async {
    if (list.isNotEmpty) {
      return;
    }
    List<GisMapMarker> markers = [];
    int index = 0;
    setPosIcon();
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
    if (!mounted) return;
    setState(() {
      controller.updateMarkers(list!);
    });
  }

  Future setMarkers() async {
    if (!mounted) return;
    setState(() {
      controller.init();
      controller.updateMarkers(list!);
    });
  }

  Widget floatingButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 65),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.gps_fixed),
              onPressed: () async {
                final status = await controller.setCameraPosition(
                    latitude: pos?.latitude, longitude: pos?.longitude);
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  build(BuildContext context) {
    precacheImage(ap.pfp, context);

    // setMarkers();
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              GisMap(
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
              floatingButton(),
            ],
          )),
    );
  }
}
