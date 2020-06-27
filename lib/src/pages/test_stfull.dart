import 'package:calcu_obstetrica/src/bloc/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calcu_obstetrica/src/providers/data_provider.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<dynamic> _frecuenciaCardiacaOptions = new List();
  List<dynamic> _frecuenciaCardiacaItems;
  String _frecuenciaCardiacaSelected;

  void _loadData() async {
    _frecuenciaCardiacaSelected = '';
    _frecuenciaCardiacaItems = await dataProvider.loadFrecuenciaCardiaca();
    _frecuenciaCardiacaOptions =
        _frecuenciaCardiacaItems.map((item) => item['option']).toList();
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Testing'),
      ),
      body: _buildContents(context, bloc),
    );
  }

  Widget _buildContents(BuildContext context, ScoreMamaBloc bloc) {
//    bloc.changeScoreMama(0);
//    print(bloc.scoreMama);
    return ListView(
      scrollDirection: Axis.horizontal,
//      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (String _fcOption in _frecuenciaCardiacaOptions)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Radio(
                  value: _fcOption,
                  groupValue: _frecuenciaCardiacaSelected,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (val) {
                    setState(() {
                      _frecuenciaCardiacaSelected = val;
                    });
                    print(_frecuenciaCardiacaSelected);
                  },
                ),
                Text(_fcOption)
              ],
            ),
          )
      ],
    );
  }
}
