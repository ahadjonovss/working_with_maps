import '../models/latlong_model.dart';
import '../services/api_service/api_service.dart';

class GeocodingRepo {
  GeocodingRepo({required this.apiService});

  final ApiService apiService;

  Future<String> getAddress(LatLong latLong, String kind) =>
      apiService.getLocationName(geoCodeText: "${latLong.long},${latLong.lat}",kind:kind );
}