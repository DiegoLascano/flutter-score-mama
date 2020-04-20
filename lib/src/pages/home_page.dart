import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:math';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

const testDevice = 'MobileID';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nativeAdController = NativeAdmobController();
  double _nativeAdHeight = 0;

  StreamSubscription _subscription;

  // Test ID
  static const _nativeUnitID = "ca-app-pub-3940256099942544/8135179316";
  // Native 2 Id
  // static const _nativeUnitID = "ca-app-pub-1500612778036594/5687730085";

  // Test ID
  static const _interstitialUnitID = "ca-app-pub-3940256099942544/8135179316";
  // Interstitial ad ID
  // static const _interstitialUnitID = "ca-app-pub-1500612778036594/4589436680";

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['medico', 'doctor', 'score'],
    // contentUrl: 'https://flutter.io',
    childDirected: false,
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;

  final List<Map<String, String>> tests = [
    {
      'title': 'Score Mamá',
      'description': 'Esta es la descripción para el test Score Mamá.'
    },
    {
      'title': 'Edad Gestacional',
      'description':
          'Calcula de forma rápida la edad gestacional y la fecha probable de parto.'
    },
  ];

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        // print("InterstitialAd event $event");
        if (event == MobileAdEvent.closed) {
          _interstitialAd?.dispose();
          _interstitialAd = createInterstitialAd()..load();
          print("InterstitialAd event $event");
        }
      },
    );
  }

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
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _appBackground(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _header(context),
                _testButtons(context),
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
              'Calculadora Obstétrica',
              style: TextStyle(
                  color: Color.fromRGBO(4, 78, 84, 1.0),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Calcula de forma rápida parámetros obstétricos',
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
                Icons.add_alert, tests[0]),
          ],
        ),
        TableRow(
          children: [
            _createNativeAd(),
            // Container(),
          ],
        ),
        TableRow(
          children: [
            _createTestButton(context, 'gestational_age', Colors.teal[800],
                Icons.calendar_today, tests[1]),
            // _createTestButton(context, '', Colors.blueGrey[800],
            //     Icons.insert_photo, 'En desarrollo'),
            // _createTestButton(context, '', Colors.blueGrey[800],
            //     Icons.insert_photo, 'En desarrollo'),
          ],
        ),
      ],
    );
  }

  Widget _createTestButton(
      BuildContext context, routeName, Color color, IconData icon, Map test) {
    final _screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        height: 160.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.6),
          // color: Color.fromRGBO(98, 125, 152, 0.7),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Row(children: <Widget>[
              Container(
                width: _screenSize.width * 0.4,
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 45.0,
                  child: Icon(icon, color: Colors.white, size: 40.0),
                ),
              ),
              Container(
                width: _screenSize.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      test['title'],
                      style: TextStyle(
                          color: color,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      test['description'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        color: color,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
      onTap: () {
        _interstitialAd?.show();
        Navigator.pushNamed(context, routeName);
      },
    );
  }

  Widget _createNativeAd() {
    return Container(
      height: _nativeAdHeight,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(
          horizontal: 20.0, vertical: (_nativeAdHeight / 16)),
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
