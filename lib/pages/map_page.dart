import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dgis_flutter/dgis_flutter.dart';
import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/search_bar.dart';
import 'package:provider/provider.dart';

// TODO geolocation

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GisMapController controller = GisMapController();
  List<GisMapMarker> list = [];
  late final Future<List<GisMapMarker>> icons =
      Future.wait([getPngFromAsset(context, "assets/pin_drop.png", 100)])
          .then((value) => [
                GisMapMarker(
                    icon: value[0],
                    latitude: 43.2567,
                    longitude: 76.9286,
                    zIndex: 0,
                    id: "123456")
              ]);

  Future<Uint8List> getPngFromAsset(
    BuildContext context,
    String path,
    int width,
  ) async {
    ByteData data = await DefaultAssetBundle.of(context).load(path);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.getCarWashesFromStorage();
    return Stack(
      children: [
        Scaffold(
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ButtonMapWidget(
                controller: controller,
                child: FutureBuilder<List<GisMapMarker>>(
                  future: icons,
                  builder: (context, snapshot) {
                    // if (!snapshot.hasData) return const SizedBox();
                    list = snapshot.data!;
                    controller.updateMarkers(list);
                    return GisMap(
                      directoryKey: 'ruqvec0919',
                      mapKey: '5f32900c-934a-4575-8f50-c7d8f1eac2f4',
                      useHybridComposition: true,
                      controller: controller,
                      onTapMarker: (marker) {
                        // ignore: avoid_print
                        print(marker.id);
                      },
                      startCameraPosition: const GisCameraPosition(
                        latitude: 43.2567,
                        longitude: 76.9286,
                        bearing: 0,
                        tilt: 0,
                        zoom: 15,
                      ),
                    );
                  },
                ),
              ),
            )
        ),
        buildFloatingSearchBar(context),
      ],
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
                        latitude: 43.2567,
                        longitude: 76.9286,
                        bearing: 0,
                        zoom: 12);
                    log(status);
                  },
                ),
              ],
            )),
      ],
    );
  }
}
