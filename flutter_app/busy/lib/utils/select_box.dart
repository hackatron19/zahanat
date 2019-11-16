import 'package:busy/screens/bus_list.dart';
import 'package:busy/utils/get_data.dart';
import 'package:flutter/material.dart';

class SelectBox extends StatefulWidget {
  @override
  _SelectBoxState createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  List<BusRoute> routeAll = List();
  List<String> routeList = List();
  List<String> bpointList = List();
  List<BPoint> bpointAll = List();
  bool routesLoaded = false;
  bool bpointsLoaded = false;
  bool get isLoaded => routesLoaded && bpointsLoaded;
  String _route;
  String _bpoint;

  int getRouteId(String name) {
    for (var i in routeAll) {
      if (name == i.name) {
        return i.id;
      }
    }
    return 10;
  }

  int getBpointId(String name) {
    for (var i in bpointAll) {
      if (name == i.name) {
        return i.id;
      }
    }
    return 10;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRoutes().then((result) {
      for (var i in result) {
        print(i);
        routeAll.add(BusRoute.fromJSON(i));
        routeList.add(BusRoute.fromJSON(i).name);
      }
      setState(() {
        routesLoaded = true;
        _route = routeList[0];
      });
    });
    fetchBPoints().then((result) {
      for (var i in result) {
        print(i);
        bpointAll.add(BPoint.fromJSON(i));
        bpointList.add(BPoint.fromJSON(i).name);
      }
      setState(() {
        bpointsLoaded = true;
        _bpoint = bpointList[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 16,
        ),
        constraints: BoxConstraints(minWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: isLoaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'Catch Your Bus',
                    style: TextStyle(color: Colors.black, fontSize: 25.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Route',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _route,
                        icon: Icon(Icons.timeline),
                        isExpanded: true,
                        style: TextStyle(color: Colors.white),
                        items: routeList
                            .map<DropdownMenuItem<String>>((var value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _route = newValue;
                          });
                        },
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Boarding Point',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      DropdownButton<String>(
                        value: _bpoint,
                        icon: Icon(Icons.location_on),
                        isExpanded: true,
                        style: TextStyle(color: Colors.white),
                        items: bpointList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _bpoint = newValue;
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                  )
                ],
              ),
      ),
      Opacity(
        opacity: isLoaded ? 1.0 : 0.0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BusList(
                            routeId: getRouteId(_route),
                            bpointId: getBpointId(_bpoint),
                          )));
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            color: Colors.black,
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
        ),
      )
    ]);
  }
}
