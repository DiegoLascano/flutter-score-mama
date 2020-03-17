import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:math';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _appBackground(),
          // Consider using SingleChildScrollView() Widget instead of Column () when there are more tests.
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _header(context),
              _testButtons(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appBackground() {
    final gradientBackground = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.5),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(240, 244, 248, 1.0),
            Color.fromRGBO(188, 204, 220, 1.0),
          ],
        ),
      ),
    );

    final topBox = Transform.rotate(
      angle: -pi / 4.0,
      child: Container(
        width: 360.0,
        height: 360.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(56, 190, 201, 1.0),
              Color.fromRGBO(190, 248, 253, 1.0),
            ])),
      ),
    );

    final rightBox = Transform.rotate(
      angle: -pi / 3.0,
      child: Container(
        width: 250.0,
        height: 250.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(38, 128, 194, 1.0),
              Color.fromRGBO(182, 224, 254, 1.0),
            ])),
      ),
    );

    final leftBox = Transform.rotate(
      angle: -pi / 2.5,
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0)
            ])),
      ),
    );

    final bottomBox = Transform.rotate(
      angle: pi / 3.0,
      child: Container(
        width: 280.0,
        height: 280.0,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(50.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(233, 185, 73, 1.0),
              Color.fromRGBO(248, 227, 163, 1.0),
            ],
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gradientBackground,
        Positioned(top: -90.0, child: topBox),
        Positioned(top: 300.0, left: -100.0, child: leftBox),
        Positioned(top: 350.0, right: -100.0, child: rightBox),
        Positioned(left: -60.0, bottom: -130.0, child: bottomBox),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Fórmulas médicas',
              style: TextStyle(
                  color: Color.fromRGBO(4, 78, 84, 1.0),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Calcula de forma rápida parámetros importantes',
              style: TextStyle(
                  color: Color.fromRGBO(4, 78, 84, 1.0), fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _testButtons(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            _createTestButton(context, 'score_mama', Colors.blue[800],
                Icons.insert_photo, 'Score Mamá'),
            _createTestButton(context, 'gestational_age', Colors.teal[800],
                Icons.insert_photo, 'Edad Gestacional'),
          ],
        ),
        TableRow(
          children: [
            _createTestButton(context, '', Colors.blueGrey[800],
                Icons.insert_photo, 'En desarrollo'),
            _createTestButton(context, '', Colors.blueGrey[800],
                Icons.insert_photo, 'En desarrollo'),
          ],
        ),
      ],
    );
  }

  Widget _createTestButton(BuildContext context, routeName, Color color,
      IconData icon, String testName) {
    return GestureDetector(
      child: Container(
        height: 210.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.6),
          // color: Color.fromRGBO(98, 125, 152, 0.7),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: color,
                  radius: 35.0,
                  child: Icon(icon, color: Colors.white, size: 30.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  testName,
                  style: TextStyle(
                      color: color,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
