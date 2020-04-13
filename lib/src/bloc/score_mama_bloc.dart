import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ScoreMamaBloc {
  final _frecuenciaCardiacaController = BehaviorSubject<String>();
  final _presionSistolicaController = BehaviorSubject<String>();
  final _presionDiastolicaController = BehaviorSubject<String>();
  final _frecuenciaRespiratoriaController = BehaviorSubject<String>();
  final _temperaturaController = BehaviorSubject<String>();
  final _saturacionController = BehaviorSubject<String>();
  final _concienciaController = BehaviorSubject<String>();
  final _proteinuriaController = BehaviorSubject<String>();
  final _semanasController = BehaviorSubject<bool>();

  // Fetch data from stream
  Stream<String> get frecuenciaCardiacaStream =>
      _frecuenciaCardiacaController.stream;
  Stream<String> get presionSistolicaStream =>
      _presionSistolicaController.stream;
  Stream<String> get presionDiastolicaStream =>
      _presionDiastolicaController.stream;
  Stream<String> get frecuenciaRespiratoriaStream =>
      _frecuenciaRespiratoriaController.stream;
  Stream<String> get temperaturaStream => _temperaturaController.stream;
  Stream<String> get saturacionStream => _saturacionController.stream;
  Stream<String> get concienciaStream => _concienciaController.stream;
  Stream<String> get proteinuriaStream => _proteinuriaController.stream;
  Stream<bool> get semanasStream => _semanasController.stream;

  Stream<bool> get formValidStream => CombineLatestStream.combine7(
      frecuenciaCardiacaStream,
      presionSistolicaStream,
      presionDiastolicaStream,
      frecuenciaRespiratoriaStream,
      temperaturaStream,
      saturacionStream,
      concienciaStream,
      (fc, ps, pd, fr, t, sat, c) => true);

  // Insert values to the stream
  Function(String) get changeFrecuenciaCardiaca =>
      _frecuenciaCardiacaController.sink.add;
  Function(String) get changePresionSistolica =>
      _presionSistolicaController.sink.add;
  Function(String) get changePresionDiastolica =>
      _presionDiastolicaController.sink.add;
  Function(String) get changeFrecuenciaRespiratoria =>
      _frecuenciaRespiratoriaController.sink.add;
  Function(String) get changeTemperatura => _temperaturaController.sink.add;
  Function(String) get changeSaturacion => _saturacionController.sink.add;
  Function(String) get changeConciencia => _concienciaController.sink.add;
  Function(String) get changeProteinuria => _proteinuriaController.sink.add;
  Function(bool) get changeSemanas => _semanasController.sink.add;

  // Get last value of the streams
  String get frecuenciaCardiaca => _frecuenciaCardiacaController.value;
  String get presionSistolica => _presionSistolicaController.value;
  String get presionDiastolica => _presionDiastolicaController.value;
  String get frecuenciaRespiratoria => _frecuenciaRespiratoriaController.value;
  String get temperatura => _temperaturaController.value;
  String get saturacion => _saturacionController.value;
  String get conciencia => _concienciaController.value;
  String get proteinuria => _proteinuriaController.value;
  bool get semanas => _semanasController.value;

  dispose() {
    _frecuenciaCardiacaController?.close();
    _presionSistolicaController?.close();
    _presionDiastolicaController?.close();
    _frecuenciaRespiratoriaController?.close();
    _temperaturaController?.close();
    _saturacionController?.close();
    _concienciaController?.close();
    _proteinuriaController?.close();
    _semanasController?.close();
  }
}
