import 'package:flutter/material.dart';
import 'package:working_with_maps/data/repositories/geocoding_repository.dart';

import '../data/models/latlong_model.dart';

class MapScreenViewModel extends ChangeNotifier{
  MapScreenViewModel({required this.geocodingRepo});

  final GeocodingRepo geocodingRepo;

  String addressText = "";
  String choosenCategory="House";



  fetchAddress({required LatLong latLong, required String kind}) async {
    addressText = await geocodingRepo.getAddress(latLong, choosenCategory);
    notifyListeners();
  }
}