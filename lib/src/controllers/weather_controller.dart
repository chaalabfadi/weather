import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather/src/services/response.dart';

class WeatherController extends ChangeNotifier {
  ResponseApi responseApi = ResponseApi();
  LocationData? locationData;
  String _path = 'assets/images/sunny.gif';

  String get path => _path;

  set path(String value) {
    _path = value;
    notifyListeners();
  }

  Future<LocationData?> getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();

    return locationData;
  }
}
