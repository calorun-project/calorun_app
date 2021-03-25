import 'dart:async';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart';

class LocationServices {
  final Location _location = new Location();
  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  static bool isMoving = false;

  Stream<LatLng> get pathPoint async* {
    await askPermission();
    isMoving = true;
    while (isMoving) {
      Future.delayed(Duration(seconds: 3));
      _locationData = await _location.getLocation();
      yield LatLng(_locationData.latitude, _locationData.longitude);
    }
  }

  Stream<LatLng> get locationListen {
    return _location.onLocationChanged
        .map((event) => LatLng(event.latitude, event.longitude));
  }

  void stopMove() {
    isMoving = false;
  }

  Future<LatLng> getCurrentLocation() async {
    await askPermission();
    return LatLng(_locationData.latitude, _locationData.longitude);
  }

  Future<void> askPermission() async {
    _serviceEnabled = await _location.requestService();
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.requestPermission();

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
  }

  Future<String> getCurrentAddress() async {
    await askPermission();
    if (_permissionGranted == PermissionStatus.denied || !_serviceEnabled)
      return '';
    List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(
        Coordinates(_locationData.latitude, _locationData.longitude));
    Address first = addresses.first;
    return '${first.subAdminArea}, ${first.adminArea}, ${first.countryName}';
  }
}
