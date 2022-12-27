import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                  return Expanded(
                    child: GoogleMap(
                      mapType: MapType.satellite,
                      onMapCreated: (controller) {},
                      initialCameraPosition: CameraPosition(
                          zoom: 19.151926040649414,
                          target:
                              LatLng(value.latLong!.lat, value.latLong!.long)),
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
