import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../models/map_model.dart';


class ApiService {
  String mapApiKey="f20daa35-95b7-4f09-abf1-5a163ad6ce19";
  Dio dio = Dio();

  Future<String> getLocationName({required String geoCodeText, required String kind}) async {
    String text = '';
    try {
      late Response response;
      Map<String, String> queryParams = {
        'apikey': mapApiKey,
        'geocode': geoCodeText,
        'lang': 'uz_UZ',
        'format': 'json',
        'kind': kind,
        'rspn': '1',
        'results': '1',
      };
      response = await dio.get(
        "https://geocode-maps.yandex.ru/1.x/",
        queryParameters: queryParams,
      );

      if (response.statusCode! == HttpStatus.ok) {
        Geocoding geocoding = Geocoding.fromJson(response.data);
        if (geocoding.response!.geoObjectCollection!.featureMember!.isNotEmpty) {
          text = geocoding.response!.geoObjectCollection!.featureMember![0]
              .geoObject!.metaDataProperty!.geocoderMetaData!.text!;
          debugPrint("text>>>>>>>>>>>> $text");
        } else {
          text = 'Aniqlanmagan hudud';
        }
        return text;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}