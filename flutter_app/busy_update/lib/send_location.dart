import 'dart:async';

import 'package:busy_update/get_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SendLocation extends StatefulWidget {
  final int busId;
  final String bno;

  SendLocation({this.busId, this.bno});

  @override
  _SendLocationState createState() => _SendLocationState();
}

class _SendLocationState extends State<SendLocation> {
  double lat = 0.0;
  double long = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
      lat = position.latitude;
      long = position.longitude;
      update_loc(widget.busId, lat, long, widget.bno);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Text('$lat and $long'),
        ),
      ),
    );
  }
}
