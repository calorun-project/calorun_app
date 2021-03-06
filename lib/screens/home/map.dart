import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:calorun/gameengine/gamedataGE.dart';
import 'package:calorun/services/database.dart';
import 'package:calorun/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:calorun/services/location.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:math' show cos, sqrt, pi, sin, atan2;
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;

class Map extends StatefulWidget {
  final String uid;
  final double weight;
  Map({this.uid, this.weight});
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> with AutomaticKeepAliveClientMixin<Map> {
  final LocationServices locationServices = LocationServices();
  bool isRunning = false;
  bool isAlive = false;
  bool isLoading = true;
  File image;

  bool get wantKeepAlive {
    if (isAlive) return true;
    return false;
  }

  // File.fromRawPath(Uint8List uint8List);
  GlobalKey globalKey = GlobalKey();

  // ScreenshotController screenshotController = ScreenshotController();

  TextEditingController timeController =
      TextEditingController(text: '00:00:00');
  TextEditingController distanceController =
      TextEditingController(text: '0.00');
  TextEditingController caloController = TextEditingController(text: '0.00');
  TextEditingController speedController = TextEditingController(text: '0.00');

  MapController screen;
  LatLng curentLocation = LatLng(0.0, 0.0);
  List<LatLng> route = <LatLng>[];
  List<Polyline> routes = <Polyline>[];
  double totalDistance = 0.0;
  double totalTime = 0.0;

  Timer timer;

  double _measure(LatLng point1, LatLng point2) {
    double r = 6371000.0; // Radius of earth in m
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
    screen = MapController();
    locationServices.askPermission();
    super.initState();
  }

  void startRun() {
    isAlive = true;
    route.add(curentLocation);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      totalTime += 1.0;
      timeController.text =
          _printDuration(Duration(seconds: totalTime.toInt()));
      distanceController.text = totalDistance.toStringAsFixed(2);
      caloController.text =
          (totalDistance * widget.weight * 0.001036).toStringAsFixed(2);
      speedController.text =
          (totalDistance / totalTime * 3.6).toStringAsFixed(2);
    });
    setState(() {
      isRunning = true;
    });
  }

  void stopRun() {
    routes.add(Polyline(
      points: route,
      strokeWidth: 6.0,
      color: Color(0xffFCA311),
    ));
    route = <LatLng>[];
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  Future<Uint8List> convertWidgetToImage() async {
    RenderRepaintBoundary renderRepaintBoundary =
        globalKey.currentContext.findRenderObject();
    ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
    ByteData byteData =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  Future<void> share() async {
    Uint8List screenshot = await convertWidgetToImage();
    String pid = Uuid().v4();
    String location = await LocationServices().getCurrentAddress();
    String downloadUrl = await StorageServices().uploadPostMap(screenshot, pid);
    await DatabaseServices(uid: widget.uid).createPostData(
        pid,
        downloadUrl,
        "Today, I run " +
            totalDistance.toStringAsFixed(0) +
            " m in about " +
            (totalTime / 60).toStringAsFixed(0) +
            " minutes.",
        location);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Uploaded'),
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  Future<void> saveRun(BuildContext context) async {
    stopRun();
    if ((totalDistance / totalTime * 3.6) > 50.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Your speed is too fast!'),
          duration: Duration(milliseconds: 500),
        ),
      );
    } else if (totalDistance < 300.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('The distance less than 300 meters can not be saved'),
          duration: Duration(milliseconds: 500),
        ),
      );
    } else {
      DatabaseServices(uid: widget.uid).updateRun(totalDistance, totalTime);
      await share();
      Calo.afterRun(
          context: context,
          kilometers: totalDistance / 1000,
          minutes: totalTime / 60);
      setState(() {
        isRunning = false;
        totalDistance = 0.0;
        distanceController.text = '0.00';
        totalTime = 0.0;
        timeController.text = '00:00:00';
        speedController.text = '0.00';
        caloController.text = '0.00';
        route.clear();
        routes.clear();
      });
      isAlive = false;
    }
  }

  void removeRun() {
    stopRun();
    setState(() {
      isRunning = false;
      totalDistance = 0.0;
      distanceController.text = '0.00';
      totalTime = 0.0;
      timeController.text = '00:00:00';
      speedController.text = '0.00';
      caloController.text = '0.00';
      route.clear();
      routes.clear();
      isAlive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          body: StreamBuilder<LatLng>(
            stream: locationServices.locationListen,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                isLoading = false;
                if (isRunning && snapshot.data != curentLocation) {
                  route.add(snapshot.data);
                  totalDistance += _measure(curentLocation, snapshot.data);
                }
                curentLocation = snapshot.data;
                screen.move(
                    LatLng(snapshot.data.latitude - 0.0002,
                        snapshot.data.longitude),
                    18.0);
              }
              return RepaintBoundary(
                key: globalKey,
                child: FlutterMap(
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
                              color: Color(0xffFCA311),
                            )
                          ],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(curentLocation.latitude + 0.000035,
                              curentLocation.longitude),
                          builder: (contex) => Container(
                            child: Icon(
                              Icons.location_on,
                              color: Color(0xff297373),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: !(isRunning || (totalTime == 0)),
          child: Align(
            alignment: Alignment(0.9, -0.9),
            child: FloatingActionButton(
              backgroundColor: Colors.red.withOpacity(0.8),
              child: Icon(Icons.close_rounded),
              heroTag: null,
              onPressed: () {
                removeRun();
                print(isAlive);
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
              height: MediaQuery.of(context).size.height * 0.32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          enableInteractiveSelection: false,
                          enabled: false,
                          controller: timeController,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "RobotoLight"),
                        ),
                      ),
                      Text(
                        "Duration",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "RobotoLight"),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          enableInteractiveSelection: false,
                          enabled: false,
                          controller: caloController,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "RobotoLight"),
                        ),
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
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: distanceController,
                          enableInteractiveSelection: false,
                          enabled: false,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "RobotoLight"),
                        ),
                      ),
                      Text(
                        "Distance (m)",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "RobotoLight"),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: speedController,
                          enableInteractiveSelection: false,
                          enabled: false,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "RobotoLight"),
                        ),
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
            onPressed: () {
              if (!isLoading) {
                isRunning ? stopRun() : startRun();
              }
            },
          ),
        ),
        Visibility(
          visible: !(isRunning || (totalTime == 0)),
          child: Align(
            alignment: Alignment(0.9, 0.9),
            child: FloatingActionButton(
              backgroundColor: Color(0xff297373),
              child: Icon(Icons.save_alt_outlined),
              heroTag: null,
              onPressed: () {
                saveRun(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
