import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:calcu_obstetrica/src/widgets/results_card_widget.dart';
import 'package:calcu_obstetrica/src/widgets/score_box_widget.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class GestationalAge extends StatefulWidget {
  @override
  _GestationalAgeState createState() => _GestationalAgeState();
}

class _GestationalAgeState extends State<GestationalAge> {
  final _nativeAdController = NativeAdmobController();
  double _nativeAdHeight = 0;
  // Test Native ID
  // static const _nativeUnitID = "ca-app-pub-3940256099942544/8135179316";
  // Native Id
  static const _nativeUnitID = "ca-app-pub-1500612778036594/4510849943";

  StreamSubscription _subscription;

  int _weeks = 0;
  int _days = 0;
  String _parsedDate = '';
  String _fppDate = '';

  DateTime _pickedDate = new DateTime.now();

  TextEditingController _fumDateController = new TextEditingController();

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _nativeAdHeight = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _nativeAdHeight = 160;
        });
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edad Gestacional'), // Refactoring UI cyan-600
      ),
      body: Stack(
        children: <Widget>[
          _appBackground(),
          Container(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                _pickFUM(context),
                SizedBox(height: 20.0),
                Text(
                  'Resultados',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 20.0),
                ResultsCard(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ScoreBox(_weeks, 'semanas'),
                      ScoreBox(_days, 'días'),
                    ],
                  ),
                  'Edad Gestacional',
                ),
                SizedBox(height: 20.0),
                _createNativeAd(),
                ResultsCard(
                  Text(
                    _fppDate,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.title.color,
                    ),
                  ),
                  'Fecha Probable de Parto',
                ),
              ],
            ),
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
        Positioned(top: 110.0, right: -200.0, child: topBox),
        // Positioned(top: 100.0, right: -100.0, child: leftBox),
        Positioned(bottom: 50.0, left: -100.0, child: rightBox),
        // Positioned(left: -60.0, bottom: -130.0, child: bottomBox),
      ],
    );
  }

  Widget _pickFUM(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _fumDateController,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Theme.of(context).textTheme.title.color,
        ),
        labelText: 'Fecha de la última menstruación',
        icon: Icon(
          Icons.calendar_today,
          color: Theme.of(context).textTheme.title.color,
        ),
        // suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 3.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      locale: Locale('es', 'ES'),
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(Duration(days: 365)),
      lastDate: new DateTime.now(),
    );

    if (picked != null) {
      _pickedDate = picked;
      _parsedDate = new DateFormat.yMMMMd('es_ES').format(picked);
      _fumDateController.text = _parsedDate;
    }
    _calcDates();
  }

  void _calcDates() {
    Duration difference = DateTime.now().difference(_pickedDate);
    int totalDays = difference.inDays;
    DateTime _fpp = _pickedDate.add(Duration(days: 280));
    setState(() {
      _weeks = (totalDays / 7).floorToDouble().toInt();
      _days = totalDays % 7;
      _fppDate = new DateFormat.yMMMd('es_ES').format(_fpp).toString();
    });
  }

  Widget _createNativeAd() {
    return Container(
      height: _nativeAdHeight,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: (_nativeAdHeight * 2 / 16)),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.6),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: NativeAdmob(
            error: Text('Error al cargar el anuncio'),
            adUnitID: _nativeUnitID,
            controller: _nativeAdController,
            options: NativeAdmobOptions(
              showMediaContent: true,
              ratingColor: Colors.amberAccent,
            ),
          ),
        ),
      ),
    );
  }
}
