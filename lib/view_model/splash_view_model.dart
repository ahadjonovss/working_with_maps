import 'package:flutter/cupertino.dart';
import 'package:working_with_maps/data/models/latlong_model.dart';

class SplashViewModel extends ChangeNotifier{

  SplashViewModel(){
    fetchCurrentLocation();
  }

  LatLong? latLong;

  fetchCurrentLocation(){

  }
}