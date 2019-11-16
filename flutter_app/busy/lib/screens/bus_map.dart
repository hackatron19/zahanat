import 'package:busy/utils/get_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class BusMap extends StatefulWidget {
  final String bno;
  final double lat;
  final double long;
  final int bpoint;

  BusMap({this.bno, this.lat, this.long, this.bpoint});

  @override
  _BusMapState createState() => _BusMapState();
}

class _BusMapState extends State<BusMap> {
  LatLng currLoc;
  LatLng bpointLoc;
  double travelDuration;
  double travelDistance;

  @override
  void initState() {
    super.initState();
    fetchCurrentLoc().then((result) {
      currLoc = LatLng(result.latitude, result.longitude);
      setState(() {});
      fetchDistMat(widget.lat, widget.long, currLoc.latitude, currLoc.longitude)
          .then((result) {
        travelDuration = result["resourceSets"][0]["resources"][0]["results"][0]
            ["travelDuration"];
        travelDistance = result["resourceSets"][0]["resources"][0]["results"][0]
            ["travelDistance"];
        setState(() {});
      });
    });
//    fetchBPointSpec(widget.bpoint).then((result) {
//      var ob = BPoint.fromJSON(result);
//      bpointLoc = LatLng(ob.lat, ob.long);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Stack(
          children: <Widget>[
            FlutterMap(
                options: MapOptions(
                  center: LatLng(widget.lat, widget.long),
                  zoom: 15,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}",
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1Ijoic3JpamFuczM4IiwiYSI6ImNqemN3cHRodzAyb2ozZG94YXZwN3VkMWYifQ.pszoH4JN8jktAkXtDl40wQ',
                      'id': 'mapbox.dark',
                    },
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(widget.lat, widget.long),
                        builder: (context) => Icon(
                          Icons.directions_bus,
                          color: Colors.orange,
                          size: 40.0,
                        ),
                      ),
                      currLoc != null
                          ? Marker(
                              width: 20.0,
                              height: 20.0,
                              point: currLoc,
                              builder: (context) => Container(
                                decoration: ShapeDecoration(
                                  shape: CircleBorder(
                                      side: BorderSide(
                                    color: Colors.white,
                                  )),
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : Marker(),
                    ],
                  ),
                ]),
            Positioned(
              top: 40.0,
              left: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 25.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 120.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Text(
                        widget.bno,
                        style: TextStyle(
                          color: Colors.black.withAlpha(200),
                          fontSize: 25.0,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40.0,
              left: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 20.0,
                  ),
                  travelDuration != null
                      ? Container(
                          width: MediaQuery.of(context).size.width - 40.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              'Reaching you in $travelDuration mins and is $travelDistance kms away',
                              style: TextStyle(
                                color: Colors.black.withAlpha(200),
                                fontSize: 15.0,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width - 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
