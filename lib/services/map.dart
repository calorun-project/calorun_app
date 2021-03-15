import 'package:flutter/material.dart';
import 'package:calorun/services/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final LocationServices locationServices = LocationServices();
  bool isRunning = false;
  MapController screen = MapController();
  LatLng curentLocation = LatLng(0.0, 0.0);
  List<LatLng> paths = <LatLng>[];

  @override
  void initState() {
    setUp();
    super.initState();
  }

  Future<void> setUp() async {
    await locationServices.askPermission();
    screen.move(curentLocation, 14.0);
  }

  void startRun() {
    paths.add(curentLocation);
    setState(() {      
      isRunning = true;
    });
  }

  void stopRun() {
    setState(() {
      isRunning = false;
      paths.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<LatLng>(
        stream: locationServices.locationListen,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (isRunning && snapshot.data != curentLocation) {
              paths.add(snapshot.data);
            }
            curentLocation = snapshot.data;
            screen.move(snapshot.data, 14.0);
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
                polylines: [
                  Polyline(
                    points: paths,
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
