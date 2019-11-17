import 'package:busy_update/get_data.dart';
import 'package:busy_update/send_location.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _busSelected;
  List busList = List();

  int getBusId(String name) {
    for (var i in busList) {
      if (name == i.bno) {
        return i.id;
      }
    }
    return 10;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBus().then((result) {
      for (var i in result) {
        busList.add(Bus.fromJSON(i));
      }
      _busSelected = busList[0].bno;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 200.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButton<String>(
                isExpanded: true,
                value: _busSelected,
                icon: Icon(Icons.map),
                style: TextStyle(color: Colors.white),
                items: busList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.bno,
                    child: Text(
                      value.bno,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    _busSelected = newValue;
                  });
                },
              ),
              OutlineButton(
                child: Text(
                  'Update Location',
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
                          builder: (context) => SendLocation(
                                busId: getBusId(_busSelected),
                                bno: _busSelected,
                              )));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                borderSide: BorderSide(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
