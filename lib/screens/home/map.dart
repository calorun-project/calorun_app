import 'dart:async';
import 'package:calorun/services/database.dart';
import 'package:flutter/material.dart';
import 'package:calorun/services/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:math' show cos, sqrt, pi, sin, atan2;

class Map extends StatefulWidget {
  final String uid;
  Map(this.uid);
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final LocationServices locationServices = LocationServices();
  bool isRunning = false;
  MapController screen = MapController();
  LatLng curentLocation = LatLng(0.0, 0.0);
  List<LatLng> route = <LatLng>[];
  List<Polyline> routes = <Polyline>[];
  double totalDistance = 0.0;
  int totalTime = 0;

  DateTime startTime = DateTime.now();
  Timer timer;

  TextEditingController distanceController;
  TextEditingController timeController;

  double _measure(LatLng point1, LatLng point2) {
    double r = 63710088.0; // Radius of earth in m
    double dLat = point2.latitude * pi / 180.0 - point1.latitude * pi / 180.0;
    double dLon = point2.longitude * pi / 180.0 - point1.longitude * pi / 180.0;
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(point1.latitude * pi / 180.0) *
            cos(point2.latitude * pi / 180.0) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return r * c;
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  Future<void> setUp() async {
    await locationServices.askPermission();
    screen.move(curentLocation, 16.0);
  }

  void startRun() {
    route.add(curentLocation);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      totalTime += 1;
    });
    setState(() {
      isRunning = true;
    });
  }

  void stopRun() {
    print(totalDistance);
    print(totalTime);
    routes.add(Polyline(
      points: route,
      strokeWidth: 6.0,
      color: Colors.blue,
    ));    
    route = <LatLng>[];
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void saveRun() {
    stopRun();
    if (totalDistance < 300.0) {
      // cuar ddangw
    } else {
      DatabaseServices(uid: widget.uid).updateRun(totalDistance, totalTime);
      setState(() {
        isRunning = false;
        totalDistance = 0.0;
        totalTime = 0;
      });
    }
  }

  void removeRun() {
    stopRun();
    setState(() {
      isRunning = false;
      totalDistance = 0.0;
      totalTime = 0;
      route.clear();
      routes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.access_alarm),
              onPressed: () {
                saveRun();
              }),
          IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                stopRun();
              })
        ],
      ),
      body: StreamBuilder<LatLng>(
        stream: locationServices.locationListen,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (isRunning && snapshot.data != curentLocation) {
              route.add(snapshot.data);
              totalDistance += _measure(curentLocation, snapshot.data);
            }
            curentLocation = snapshot.data;
            screen.move(snapshot.data, 16.0);
          }
          return FlutterMap(
            mapController: screen,
            options: MapOptions(
              center: curentLocation,
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              PolylineLayerOptions(
                polylines: routes +
                    [
                      Polyline(
                        points: route,
                        strokeWidth: 6.0,
                        color: Colors.blue,
                      )
                    ],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: curentLocation,
                    builder: (contex) => Container(
                      child: Icon(
                        Icons.location_on,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow_rounded),
        onPressed: isRunning ? stopRun : startRun,
      ),
    );
  }
}
