import 'dart:typed_data';
import 'dart:ui';

import 'package:dgis_flutter/dgis_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:provider/provider.dart';

// TODO markers

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GisMapController controller = GisMapController();
  List<GisMapMarker> list = [];
  late AuthProvider ap;


  @override
  build(BuildContext context) {
    ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GisMap(
          directoryKey: 'ruqvec0919',
          mapKey: '5f32900c-934a-4575-8f50-c7d8f1eac2f4',
          useHybridComposition: true,
          controller: ap.controller,
          onTapMarker: (marker) {
            // ignore: avoid_print
            print("marker pressed");
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
                ),
              ],
            )),
      ],
    );
  }
}
