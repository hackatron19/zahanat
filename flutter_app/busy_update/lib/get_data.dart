import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

String apiToken = 'a36e75d535bff6ab679ac260aea0f64cdd89379c';

Future<List> fetchBus() async {
  final response = await http.get(
    'https://busy-hackatron.herokuapp.com/api/bus/',
    headers: {"Authorization": "Token $apiToken"},
  );
  return json.decode(response.body);
}

void update_loc(int busId, double lat, double long, String bno) {
  var req = http.put('https://busy-hackatron.herokuapp.com/api/loc/$busId/',
      headers: {
        "Authorization": "Token $apiToken"
      },
      body: {
        "id": "$busId",
        "lat": "$lat",
        "long": "$long",
        "bus": "$busId",
        "bno": "$bno"
      });
  req.then((res) {
    print(res.body);
  });
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
