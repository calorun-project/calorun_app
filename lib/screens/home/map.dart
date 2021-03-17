import 'dart:async';
import 'package:calorun/services/database.dart';
import 'package:flutter/material.dart';
import 'package:calorun/services/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:math' show cos, sqrt, pi, sin, atan2;

class Map extends StatefulWidget {
  final String uid;
  final double weight;
  Map({this.uid, this.weight});
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final LocationServices locationServices = LocationServices();
  bool isRunning = false;

  TextEditingController timeController =
      TextEditingController(text: '00:00:00');
  TextEditingController distanceController;
  TextEditingController caloController;
  TextEditingController speedController;

  //TODO: check xem chay chua?
  bool haveRun = false;

  MapController screen = MapController();
  LatLng curentLocation = LatLng(0.0, 0.0);
  List<LatLng> route = <LatLng>[];
  List<Polyline> routes = <Polyline>[];
  double totalDistance = 0.0;
  int totalTime = 0;

  DateTime startTime = DateTime.now();
  Timer timer;

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

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    setUp();
    super.initState();
  }

  Future<void> setUp() async {
    await locationServices.askPermission();
    screen.move(curentLocation, 18.0);
  }

  void startRun() {
    route.add(curentLocation);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      totalTime += 1;
      timeController.text = _printDuration(Duration(seconds: totalTime));
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
        route.clear();
        routes.clear();
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
    return Stack(
      children: <Widget>[
        Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Color(0xff297373),
          //   actions: [
          //     IconButton(
          //         icon: Icon(Icons.save_alt_outlined),
          //         onPressed: () {
          //           saveRun();
          //         }),
          //     IconButton(
          //         icon: Icon(Icons.delete),
          //         onPressed: () {
          //           removeRun();
          //         })
          //   ],
          // ),
          body: StreamBuilder<LatLng>(
            stream: locationServices.locationListen,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (isRunning && snapshot.data != curentLocation) {
                  route.add(snapshot.data);
                  totalDistance += _measure(curentLocation, snapshot.data);
                }
                curentLocation = snapshot.data;
                screen.move(snapshot.data, 18.0);
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
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: isRunning ? Color(0xffFCA311):Color(0xff297373),
          //   child: isRunning ? Icon(Icons.pause, size: 40,) : Icon(Icons.play_arrow_rounded, size: 40),
          //   onPressed: isRunning ? stopRun : startRun,
          // ),
        ),
        Visibility(
          visible: haveRun,
          child: Align(
            alignment: Alignment(0.9, -0.9),
            child: FloatingActionButton(
              backgroundColor: Colors.red.withOpacity(0.8),
              child: Icon(Icons.close_rounded),
              heroTag: null,
              onPressed: () {
                removeRun();
              },
            ),
          ),
        ),
        Align(
            alignment: Alignment(0, 1),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff297373).withOpacity(0.75),
                    Color(0xff297373).withOpacity(0.5),
                    Color(0xff297373).withOpacity(0.4),
                    Colors.transparent
                  ],
                ),
              ),
              height: 220,
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // TextField(
                      //   controller: timeController,
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 30,
                      //       fontFamily: "RobotoLight"),
                      // ),
                      Text(
                        _printDuration(Duration(seconds: totalTime)),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "RobotoLight"),
                      ),
                      Text(
                        "Duration",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "RobotoLight"),
                      ),
                      SizedBox(height: 30),
                      Text(
                        (totalDistance * widget.weight * 0.001036)
                            .toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "RobotoLight"),
                      ),
                      Text(
                        "Calories burned",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "RobotoLight"),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        (totalDistance).toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "RobotoLight"),
                      ),
                      TextField(
                        controller: TextEditingController(text: '00:00:00'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "RobotoLight"),
                      ),
                      Text(
                        "Distance (m)",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "RobotoLight"),
                      ),
                      SizedBox(height: 30),
                      Text(
                        (totalDistance / (totalTime + 0.0000001) * 3.6)
                            .toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "RobotoLight"),
                      ),
                      Text(
                        "Speed (km/h)",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "RobotoLight"),
                      ),
                    ],
                  )
                ],
              ),
            )),
        Align(
          alignment: Alignment(0, 0.23),
          child: FloatingActionButton(
            backgroundColor: isRunning ? Color(0xffFCA311) : Color(0xff297373),
            child: isRunning
                ? Icon(
                    Icons.pause,
                    size: 40,
                  )
                : Icon(Icons.play_arrow_rounded, size: 40),
            onPressed: isRunning ? stopRun : startRun,
          ),
        ),
        Visibility(
          visible: haveRun,
          child: Align(
            alignment: Alignment(0.9, 0.9),
            child: FloatingActionButton(
              backgroundColor: Color(0xff297373),
              child: Icon(Icons.save_alt_outlined),
              heroTag: null,
              onPressed: () {
                print("object");
              },
            ),
          ),
        ),
      ],
    );
  }
}
