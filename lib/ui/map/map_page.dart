import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:working_with_maps/view_model/map_screen_view_model.dart';
import 'package:working_with_maps/view_model/splash_view_model.dart';

import '../../data/models/latlong_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late CameraPosition initialCameraPosition;
  late CameraPosition cameraPosition;

  Set<Marker> mapMarkers = {};

  _init() {
    initialCameraPosition = CameraPosition(
      target: LatLng(
        context.read<SplashViewModel>().latLong!.lat,
        context.read<SplashViewModel>().latLong!.long,
      ),
      zoom: 15,
    );
    cameraPosition = CameraPosition(
      target: LatLng(
        context.read<SplashViewModel>().latLong!.lat,
        context.read<SplashViewModel>().latLong!.long,
      ),
      zoom: 15,
    );
  }
  @override
  void initState() {
    _init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        _addMarker(context.read<MapScreenViewModel>().addressText);

      },),
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text("Choose the type"),
                DropdownButton(
                  // Initial Value
                  value: context.read<MapScreenViewModel>().choosenCategory,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: ["House","Street","Locality","District"].map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged:
                      (String? newValue) {
                    setState(() {
                      context.read<MapScreenViewModel>().choosenCategory = newValue!;
                    });
                  },
                ),
              ],
            ),
            Consumer<SplashViewModel>(
              builder: (context, value, child) {
                if (value.latLong != null) {
                  Future.microtask(() => context.read<MapScreenViewModel>().fetchAddress(
                      latLong: LatLong(
                          lat: value.latLong!.lat, long: value.latLong!.long),
                      kind: context.read<MapScreenViewModel>().choosenCategory));
                  return GoogleMap(
                    onCameraMove: (position) {
                      cameraPosition = position;
                    },
                    markers: mapMarkers,
                    mapType: MapType.hybrid,
                    onMapCreated: (controller) {},
                    initialCameraPosition: CameraPosition(
                        zoom: 19.151926040649414,
                        target:
                        LatLng(value.latLong!.lat, value.latLong!.long)),
                  );
                }
                return Container();
              },
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  "assets/location_icon.png",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _addMarker(String title) async {
    Uint8List markerImage = await getBytesFromAsset(
      "assets/ronaldo.png",
      150,
    );
    mapMarkers.add(
      Marker(
        markerId: MarkerId(cameraPosition.target.latitude.toString()),
        infoWindow: InfoWindow(
          title: "Manzil",
          snippet: title,
        ),
        position: cameraPosition.target,
        icon: BitmapDescriptor.fromBytes(markerImage),
      ),
    );
    setState(() {});
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
