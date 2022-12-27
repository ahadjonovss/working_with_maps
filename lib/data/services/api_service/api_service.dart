import 'package:dio/dio.dart';

import 'api_client.dart';

class MyResponse {
  String error;
  dynamic data;
  MyResponse({this.data, required this.error});
}

class ApiService extends ApiClient {


}