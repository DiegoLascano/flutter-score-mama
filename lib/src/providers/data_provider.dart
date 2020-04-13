import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _DataProvider {
  Future<Map> loadData() async {
    final response = await rootBundle.loadString('data/data.json');
    final decoded = json.decode(response);

    Map dataMap = decoded['data'][0];

    return dataMap;
  }

  Future<List<dynamic>> loadFrecuenciaCardiaca() async {
    List<dynamic> _frecuenciaCardiacaOptions = [];
    Map dataMap = await loadData();
    _frecuenciaCardiacaOptions = dataMap['frecuenciaCardiaca'];

    return _frecuenciaCardiacaOptions;
  }

  Future<List<dynamic>> loadPresionSistolica() async {
    List<dynamic> _presionSistolicaOptions = [];
    Map dataMap = await loadData();
    _presionSistolicaOptions = dataMap['sistolica'];

    return _presionSistolicaOptions;
  }

  Future<List<dynamic>> loadPresionDiastolica() async {
    List<dynamic> _presionDiastolicaOptions = [];
    Map dataMap = await loadData();
    _presionDiastolicaOptions = dataMap['diastolica'];

    return _presionDiastolicaOptions;
  }

  Future<List<dynamic>> loadFrecuenciaRespiratoria() async {
    List<dynamic> _frecuenciaRespiratoriaOptions = [];
    Map dataMap = await loadData();
    _frecuenciaRespiratoriaOptions = dataMap['frecuenciaRespitatoria'];

    return _frecuenciaRespiratoriaOptions;
  }

  Future<List<dynamic>> loadTemperatura() async {
    List<dynamic> _temperaturaOptions = [];
    Map dataMap = await loadData();
    _temperaturaOptions = dataMap['temperatura'];

    return _temperaturaOptions;
  }

  Future<List<dynamic>> loadSaturacion() async {
    List<dynamic> _saturacionOptions = [];
    Map dataMap = await loadData();
    _saturacionOptions = dataMap['saturacion'];

    return _saturacionOptions;
  }

  Future<List<dynamic>> loadConciencia() async {
    List<dynamic> _concienciaOptions = [];
    Map dataMap = await loadData();
    _concienciaOptions = dataMap['conciencia'];

    return _concienciaOptions;
  }

  Future<List<dynamic>> loadProteinuria() async {
    List<dynamic> _proteinuriaOptions = [];
    Map dataMap = await loadData();
    _proteinuriaOptions = dataMap['proteinuria'];

    return _proteinuriaOptions;
  }
}

final dataProvider = new _DataProvider();
