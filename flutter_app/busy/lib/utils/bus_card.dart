import 'package:busy/screens/bus_map.dart';
import 'package:flutter/material.dart';

class BusCard extends StatefulWidget {
  final String busNo;
  final double lat;
  final double long;
  final int bpoint;

  BusCard({this.busNo, this.long, this.lat, this.bpoint});

  @override
  _BusCardState createState() => _BusCardState();
}

class _BusCardState extends State<BusCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 16,
      ),
      constraints: BoxConstraints(
        minWidth: 400,
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text(
              widget.busNo,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Center(
            child: Text(
              'Near ${widget.lat}, ${widget.long}',
            ),
          ),
          OutlineButton(
            child: Text(
              'Show in Map',
              style: TextStyle(
                  color: Colors.black.withAlpha(200),
                  fontSize: 15.0,
                  fontFamily: 'Montserrat'),
            ),
            splashColor: Colors.deepOrangeAccent,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BusMap(
                            bno: widget.busNo,
                            lat: widget.lat,
                            long: widget.long,
                          )));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            borderSide: BorderSide(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
