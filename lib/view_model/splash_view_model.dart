import 'package:flutter/cupertino.dart';
import 'package:working_with_maps/data/models/latlong_model.dart';
import 'package:location/location.dart';

class SplashViewModel extends ChangeNotifier{

  SplashViewModel(){
    fetchCurrentLocation();
  }

  LatLong? latLong;
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  Location location = Location();

  fetchCurrentLocation() async {

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await location.getLocation();
    latLong = LatLong(
      lat: locationData.latitude!,
      long: locationData.longitude!,
    );
    await Future.delayed(const Duration(seconds: 3));
    notifyListeners();
  }
}