import 'package:busy/utils/select_box.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 50, 16, 30),
        decoration: BoxDecoration(color: Colors.orangeAccent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'BUSy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              'The best way to find your bus.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Flexible(
              flex: 2,
              child: SelectBox(),
            )
          ],
        ),
      ),
    );
  }
}
