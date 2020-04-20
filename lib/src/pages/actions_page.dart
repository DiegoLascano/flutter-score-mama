import 'package:flutter/material.dart';

import 'dart:ui';
import 'dart:math';

import 'package:calcu_obstetrica/src/bloc/bloc_provider.dart';
import 'package:calcu_obstetrica/src/providers/data_provider.dart';

class ActionsPage extends StatefulWidget {
  @override
  _ActionsPageState createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  List<dynamic> _establecimientoOptions;
  List<dynamic> _establecimientoItems;
  List<dynamic> _proceduresItems;
  String _establecimientoActualDescripcion;

  void _loadData() async {
    _establecimientoItems = await dataProvider.loadEstablecimiento();
    _establecimientoOptions =
        _establecimientoItems.map((item) => item['type']).toList();

    _proceduresItems = await dataProvider.loadProcedures();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _loadData();
    _establecimientoActualDescripcion =
        'Puesto de salud, Centros de salud tipo A, B, y de atención prehospitalaria';
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    // bloc.changeScoreMama(5);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pasos a seguir'),
      ),
      body: Stack(children: <Widget>[
        _appBackground(),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _scoreResult(bloc),
              SizedBox(height: 20.0),
              _establecimiento(bloc),
              SizedBox(height: 20.0),
              Expanded(
                child: _createBottom(bloc),
              )
            ],
          ),
        ),
      ]),
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
        // Positioned(top: -120.0, child: topBox),
        Positioned(top: 100.0, left: -100.0, child: rightBox),
        Positioned(top: 250.0, right: -200.0, child: bottomBox),
        Positioned(left: 60.0, bottom: 20.0, child: leftBox),
      ],
    );
  }

  Widget _scoreResult(ScoreMamaBloc bloc) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _getScoreboxColor(bloc.scoreMama),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
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
        ),
      ),
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

  Widget _establecimientoDropdown(ScoreMamaBloc bloc) {
    return StreamBuilder(
      stream: bloc.establecimientoStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return DropdownButton(
          isDense: false,
          value: bloc.establecimiento,
          items: getDropdownOptions(_establecimientoOptions),
          onChanged: (value) {
            bloc.changeEstablecimiento(value);
            setState(() {
              _establecimientoActualDescripcion = _establecimientoItems
                  .where((item) => item['type'] == value ? true : false)
                  .toList()[0]['option'];
            });
          },
        );
      },
    );
  }

  Widget _establecimiento(ScoreMamaBloc bloc) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tipo de establecimiento'),
                  ),
                  _establecimientoDropdown(bloc),
                ],
              ),
              _getDescription(bloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDescription(ScoreMamaBloc bloc) {
    if (bloc.establecimiento == null) {
      return Container();
    } else {
      return Text(_establecimientoActualDescripcion);
    }
  }

  Widget _createBottom(ScoreMamaBloc bloc) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.7),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: _createActions(bloc)),
      ),
    );
  }

  Widget _createActions(ScoreMamaBloc bloc) {
    dynamic _actions = _fetchActions(bloc);
    if (_actions == null) {
      return Container();
    } else {
      return ListView.builder(
        itemCount: _actions.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                leading: CircleAvatar(
                  backgroundColor: _getScoreboxColor(bloc.scoreMama),
                  radius: 25.0,
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  _actions[index],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  _fetchActions(ScoreMamaBloc bloc) {
    if (bloc.establecimiento == null) {
      return null;
    } else {
      dynamic _procedureOptions = _proceduresItems
          .where((item) => item['type'] == bloc.establecimiento ? true : false)
          .toList()[0]['options'];

      List _actions = _procedureOptions
          .where((item) => bloc.scoreMama >= item['scoreA'] &&
                  bloc.scoreMama < item['scoreB']
              ? true
              : false)
          .toList()[0]['data']['actions'];

      return _actions;
    }
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
