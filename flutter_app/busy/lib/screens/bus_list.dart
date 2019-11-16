import 'package:busy/utils/bus_card.dart';
import 'package:busy/utils/get_data.dart';
import 'package:flutter/material.dart';

class BusList extends StatefulWidget {
  final int routeId;
  final int bpointId;
  BusList({this.routeId, this.bpointId});

  @override
  _BusListState createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  List<Bus> busList = List();

  @override
  void initState() {
    super.initState();
    fetchBusbyRoute(widget.routeId).then((result) {
      for (var i in result) {
        busList.add(Bus.fromJSON(i));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orangeAccent,
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 16.0,
        ),
        child: FutureBuilder(
          future: fetchBusbyRoute(widget.routeId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: busList.map((var value) {
                  return BusCard(
                    busNo: value.bno,
                    lat: value.lat,
                    long: value.long,
                    bpoint: widget.bpointId,
                  );
                }).toList(),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
