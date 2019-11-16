import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

String apiToken = 'a36e75d535bff6ab679ac260aea0f64cdd89379c';
String bingToken =
    'Ajb5cBYG4DdffO9dIl4wRR3RVQSEhOQ4zOXIGWxURNl24Ro6E9qOgcwGBHwsuW6v';

Future<Position> fetchCurrentLoc() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<dynamic> fetchDistMat(
    var buslat, var buslong, var blat, var blong) async {
  final response = await http.get(
    'https://dev.virtualearth.net/REST/v1/Routes/DistanceMatrix?origins=${buslat},${buslong}&destinations=${blat},${blong}&travelMode=driving&key=${bingToken}',
    headers: {"Authorization": "Token $apiToken"},
  );
  return json.decode(response.body);
}

Future<List> fetchBusbyRoute(int routeId) async {
  final response = await http.get(
    'https://busy-hackatron.herokuapp.com/api/bus?routes=$routeId',
    headers: {"Authorization": "Token $apiToken"},
  );
  return json.decode(response.body);
}

Future<List> fetchRoutes() async {
  final response = await http.get(
    'https://busy-hackatron.herokuapp.com/api/route/',
    headers: {"Authorization": "Token $apiToken"},
  );
  return json.decode(response.body);
}

Future<List> fetchBPoints() async {
  final response = await http.get(
    'https://busy-hackatron.herokuapp.com/api/bpoint/',
    headers: {"Authorization": "Token $apiToken"},
  );
  return json.decode(response.body);
}

Future<dynamic> fetchBPointSpec(int bpointId) async {
  final response = await http.get(
    'https://busy-hackatron.herokuapp.com/api/bpoint/$bpointId/',
    headers: {"Authorization": "Token $apiToken"},
  );
  return json.decode(response.body);
}

class Bus {
  final int id;
  final String bno;
  final String driver;
  final String conductor;
  final int route;
  final int status;
  final double lat;
  final double long;

  Bus({
    this.bno,
    this.conductor,
    this.driver,
    this.id,
    this.route,
    this.status,
    this.long,
    this.lat,
  });

  factory Bus.fromJSON(Map<String, dynamic> json) {
    return Bus(
        id: json['id'],
        bno: json['bno'],
        driver: json['driver'],
        conductor: json['conductor'],
        route: json['route'],
        status: json['status'],
        lat: json['lat'],
        long: json['long']);
  }
}

class BusRoute {
  final int id;
  final String source;
  final String destination;
  String name;

  BusRoute({
    this.id,
    this.source,
    this.destination,
  }) {
    this.name = "$source to $destination";
  }

  factory BusRoute.fromJSON(Map<String, dynamic> json) {
    return BusRoute(
      id: json['id'],
      source: json['source'],
      destination: json['destination'],
    );
  }
}

class BPoint {
  final int id;
  final String name;
  final String code;
  final double lat;
  final double long;
  final List routes;

  BPoint({this.name, this.id, this.code, this.lat, this.long, this.routes});

  factory BPoint.fromJSON(Map<String, dynamic> json) {
    return BPoint(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      lat: json['lat'],
      long: json['long'],
      routes: json['routes'],
    );
  }
}
