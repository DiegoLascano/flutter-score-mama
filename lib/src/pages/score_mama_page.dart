import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'dart:math';

import 'package:calcu_obstetrica/src/bloc/bloc_provider.dart';
import 'package:calcu_obstetrica/src/providers/data_provider.dart';
// import 'package:calcu_obstetrica/src/widgets/results_card_widget.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class ScoreMama extends StatefulWidget {
  @override
  _ScoreMamaState createState() => _ScoreMamaState();
}

class _ScoreMamaState extends State<ScoreMama> {
  final _nativeAdController = NativeAdmobController();
  double _nativeAdHeight = 0;
  // Test ID
  static const _nativeUnitID = "ca-app-pub-3940256099942544/8135179316";
  StreamSubscription _subscription;

  bool _weeksEnabled;
  bool _altitud;

  List<dynamic> _frecuenciaCardiacaOptions = new List();
  List<dynamic> _frecuenciaCardiacaItems;

  List<dynamic> _presionSistolicaOptions = new List();
  List<dynamic> _presionSistolicaItems;

  List<dynamic> _presionDiastolicaOptions = new List();
  List<dynamic> _presionDiastolicaItems;

  List<dynamic> _frecuenciaRespiratoriaOptions = new List();
  List<dynamic> _frecuenciaRespiratoriaItems;

  List<dynamic> _temperaturaOptions = new List();
  List<dynamic> _temperaturaItems;

  List<dynamic> _saturacionOptions = new List();
  List<dynamic> _saturacionItems;

  List<dynamic> _concienciaOptions = new List();
  List<dynamic> _concienciaItems;

  List<dynamic> _proteinuriaOptions = new List();
  List<dynamic> _proteinuriaItems;

  void _loadData() async {
    _frecuenciaCardiacaItems = await dataProvider.loadFrecuenciaCardiaca();
    _frecuenciaCardiacaOptions =
        _frecuenciaCardiacaItems.map((item) => item['option']).toList();

    _presionSistolicaItems = await dataProvider.loadPresionSistolica();
    _presionSistolicaOptions =
        _presionSistolicaItems.map((item) => item['option']).toList();

    _presionDiastolicaItems = await dataProvider.loadPresionDiastolica();
    _presionDiastolicaOptions =
        _presionDiastolicaItems.map((item) => item['option']).toList();

    _frecuenciaRespiratoriaItems =
        await dataProvider.loadFrecuenciaRespiratoria();
    _frecuenciaRespiratoriaOptions =
        _frecuenciaRespiratoriaItems.map((item) => item['option']).toList();

    _temperaturaItems = await dataProvider.loadTemperatura();
    _temperaturaOptions =
        _temperaturaItems.map((item) => item['option']).toList();

    _saturacionItems = await dataProvider.loadSaturacion();
    _saturacionOptions =
        _saturacionItems.map((item) => item['option']).toList();

    _concienciaItems = await dataProvider.loadConciencia();
    _concienciaOptions =
        _concienciaItems.map((item) => item['option']).toList();

    _proteinuriaItems = await dataProvider.loadProteinuria();
    _proteinuriaOptions =
        _proteinuriaItems.map((item) => item['option']).toList();

    setState(() {});
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
          _nativeAdHeight = 80;
        });
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    _loadData();
    _weeksEnabled = false;
    _altitud = false;
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
    // final _screenSize = MediaQuery.of(context).size;
    final bloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Mamá'),
      ),
      body: Stack(
        children: <Widget>[
          _appBackground(),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                _scoreResult(bloc),
                SizedBox(height: 20.0),
                _createNativeAd(),
                Expanded(
                  child: SingleChildScrollView(
                    child: _createInputs(bloc),
                  ),
                )
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
        width: 310.0,
        height: 310.0,
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
        Positioned(top: -100.0, left: -50.0, child: topBox),
        Positioned(top: 400.0, left: -100.0, child: leftBox),
        // Positioned(top: 350.0, right: -100.0, child: rightBox),
        Positioned(right: -160.0, bottom: -100.0, child: bottomBox),
      ],
    );
  }

  Widget _scoreResult(ScoreMamaBloc bloc) {
    return StreamBuilder<int>(
      stream: bloc.scoreMamaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (bloc.scoreMama == null) {
          bloc.changeScoreMama(0);
        }
        return GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: _getScoreboxColor(bloc.scoreMama),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Resultado',
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).textTheme.title.color,
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          bloc.scoreMama.toString(),
                          style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.title.color,
                          ),
                        ),
                        Text(
                          'puntos',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).textTheme.title.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'actions');
          },
        );
      },
    );
  }

  Widget _createNativeAd() {
    return Container(
      height: _nativeAdHeight,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(bottom: (_nativeAdHeight * 4 / 16)),
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
              showMediaContent: false,
              ratingColor: Colors.amberAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createInputs(ScoreMamaBloc bloc) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            borderRadius: BorderRadius.circular(20.0),
          ),
          // child: Text('test'),
          child: Column(
            children: <Widget>[
              _weeksSelector(bloc),
              Divider(thickness: 1.0),
              _altitudSelector(),
              Divider(thickness: 1.0),
              _frecuenciaCardiaca(bloc),
              Divider(thickness: 1.0),
              _presionSistolica(bloc),
              Divider(thickness: 1.0),
              _presionDiastolica(bloc),
              Divider(thickness: 1.0),
              _frecuenciaRespiratoria(bloc),
              Divider(thickness: 1.0),
              _temperatura(bloc),
              Divider(thickness: 1.0),
              _saturacion(bloc),
              Divider(thickness: 1.0),
              _conciencia(bloc),
              Divider(thickness: 1.0),
              _proteinuria(bloc),
              _buttonCalc(bloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _weeksSelector(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.semanasStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('20 o más semanas de embarazo?'),
            Checkbox(
              value: _weeksEnabled,
              onChanged: (value) {
                bloc.changeSemanas(value);
                // print(bloc.proteinuria);
                setState(() {
                  _weeksEnabled = value;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _altitudSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Vive a más de 2500m de altitud?'),
        Checkbox(
          value: _altitud,
          onChanged: (value) {
            setState(() {
              _altitud = value;
            });
          },
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> getDropdownOptions(List<dynamic> options) {
    List<DropdownMenuItem<String>> list = new List();

    options.forEach(
      (option) {
        list.add(
          DropdownMenuItem(
            child: Text(option),
            value: option,
          ),
        );
      },
    );
    return list;
  }

  Widget _frecuenciaCardiaca(ScoreMamaBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Frecuencia cardíaca'),
          Row(
            children: <Widget>[
              _frecuenciaCardiacaDropdown(bloc),
              SizedBox(width: 5.0),
              Text('lat/m'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _frecuenciaCardiacaDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.frecuenciaCardiacaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: true,
          value: bloc.frecuenciaCardiaca,
          items: getDropdownOptions(_frecuenciaCardiacaOptions),
          onChanged: bloc.changeFrecuenciaCardiaca,
        );
      },
    );
  }

  Widget _presionSistolica(ScoreMamaBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Presión sistólica'),
          Row(
            children: <Widget>[
              _presionSistolicaDropdown(bloc),
              SizedBox(width: 5.0),
              Text('mmHg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _presionSistolicaDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.presionSistolicaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: true,
          value: bloc.presionSistolica,
          items: getDropdownOptions(_presionSistolicaOptions),
          onChanged: bloc.changePresionSistolica,
        );
      },
    );
  }

  Widget _presionDiastolica(ScoreMamaBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Presión diastólica'),
          Row(
            children: <Widget>[
              _presionDiastolicaDropdown(bloc),
              SizedBox(width: 5.0),
              Text('mmHg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _presionDiastolicaDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.presionDiastolicaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: true,
          value: bloc.presionDiastolica,
          items: getDropdownOptions(_presionDiastolicaOptions),
          onChanged: bloc.changePresionDiastolica,
        );
      },
    );
  }

  Widget _frecuenciaRespiratoria(ScoreMamaBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Frecuencia respiratoria'),
          Row(
            children: <Widget>[
              _frecuenciaRespiratoriaDropdown(bloc),
              SizedBox(width: 5.0),
              Text('res/m'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _frecuenciaRespiratoriaDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.frecuenciaRespiratoriaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: true,
          value: bloc.frecuenciaRespiratoria,
          items: getDropdownOptions(_frecuenciaRespiratoriaOptions),
          onChanged: bloc.changeFrecuenciaRespiratoria,
        );
      },
    );
  }

  Widget _temperatura(ScoreMamaBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Temperatura'),
          Row(
            children: <Widget>[
              _temperaturaDropdown(bloc),
              SizedBox(width: 5.0),
              Text('°C'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _temperaturaDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.temperaturaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: true,
          value: bloc.temperatura,
          items: getDropdownOptions(_temperaturaOptions),
          onChanged: bloc.changeTemperatura,
        );
      },
    );
  }

  Widget _saturacion(ScoreMamaBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Saturación de oxígeno'),
          Row(
            children: <Widget>[
              _saturacionDropdown(bloc),
              SizedBox(width: 5.0),
              Text('%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _saturacionDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.saturacionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: true,
          value: bloc.saturacion,
          items: getDropdownOptions(_saturacionOptions),
          onChanged: bloc.changeSaturacion,
        );
      },
    );
  }

  Widget _conciencia(ScoreMamaBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Estado de conciencia'),
          ),
          _concienciaDropdown(bloc),
        ],
      ),
    );
  }

  Widget _concienciaDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.concienciaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: false,
          value: bloc.conciencia,
          items: getDropdownOptions(_concienciaOptions),
          onChanged: bloc.changeConciencia,
        );
      },
    );
  }

  Widget _proteinuria(ScoreMamaBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Proteinuria'),
          _proteinuriaDropdown(bloc),
        ],
      ),
    );
  }

  Widget _proteinuriaDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.proteinuriaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: true,
          value: bloc.proteinuria,
          items: getDropdownOptions(_proteinuriaOptions),
          onChanged: _weeksEnabled ? bloc.changeProteinuria : null,
        );
      },
    );
  }

  Widget _buttonCalc(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child:
                Text('Calcular Score Mamá', style: TextStyle(fontSize: 16.0)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 0.0,
            color: Color(0xFF14919B),
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _calculate(bloc) : null,
          ),
        );
      },
    );
  }

  _calculate(ScoreMamaBloc bloc) {
    int score = 0;
    score += _frecuenciaCardiacaItems
        .where(
            (item) => item['option'] == bloc.frecuenciaCardiaca ? true : false)
        .toList()[0]['score'];
    score += _presionSistolicaItems
        .where((item) => item['option'] == bloc.presionSistolica ? true : false)
        .toList()[0]['score'];
    score += _presionDiastolicaItems
        .where(
            (item) => item['option'] == bloc.presionDiastolica ? true : false)
        .toList()[0]['score'];
    score += _temperaturaItems
        .where((item) => item['option'] == bloc.temperatura ? true : false)
        .toList()[0]['score'];
    int saturation = _saturacionItems
        .where((item) => item['option'] == bloc.saturacion ? true : false)
        .toList()[0]['score'];
    (_altitud && saturation == 1) ? score += 0 : score += saturation;
    score += _concienciaItems
        .where((item) => item['option'] == bloc.conciencia ? true : false)
        .toList()[0]['score'];
    if (_weeksEnabled && bloc.proteinuria != null) {
      score += _proteinuriaItems
          .where((item) => item['option'] == bloc.proteinuria ? true : false)
          .toList()[0]['score'];
    }
    bloc.changeScoreMama(score);
  }

  Color _getScoreboxColor(int scoreMama) {
    if (scoreMama == 0) {
      return Color.fromRGBO(190, 248, 253, 0.6);
    } else if (scoreMama == 1) {
      return Color.fromRGBO(255, 189, 189, 0.7);
    } else if (scoreMama >= 2 && scoreMama <= 4) {
      return Color.fromRGBO(255, 148, 102, 0.7);
    } else if (scoreMama >= 5) {
      return Color.fromRGBO(243, 86, 39, 0.7);
    } else {
      return Color.fromRGBO(255, 255, 255, 0.7);
    }
  }
}
