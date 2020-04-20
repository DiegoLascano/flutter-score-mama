import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _appBackground(),
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                _createHeader(context),
                SizedBox(height: 20.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: _createDescription(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
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
        Positioned(top: 120.0, left: -180.0, child: topBox),
        Positioned(top: 80.0, right: -100.0, child: leftBox),
        // Positioned(top: 350.0, right: -100.0, child: rightBox),
        Positioned(right: -60.0, bottom: -100.0, child: bottomBox),
      ],
    );
  }

  Widget _createHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              Text('Calculadora Obstétrica',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(height: 5.0),
              Text('NextTech Development',
                  style:
                      TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0)),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 16.0,
                      color: Colors.grey[800],
                    ),
                    children: [
                      TextSpan(
                        text: 'nextechdevelopment@gmail.com',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createDescription(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 16.0,
                      color: Colors.grey[800],
                    ),
                    children: [
                      TextSpan(
                        text: 'La aplicación ',
                      ),
                      TextSpan(
                        text: 'Calculadora Obstétrica ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2.0),
                      ),
                      TextSpan(
                        text:
                            ' fue creada con el objetivo de facilitar a los funcionarios de la salud sus actividades cotidianas, con el apoyo de tecnologías modernas y al alcance de su mano. Esta aplicación en su primera versión, ofrece dos calculadoras importantes: la primera es el Score MAMÁ, y la segunda es la Edad Gestacional.',
                      ),
                    ]),
              ),
              SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 16.0,
                      color: Colors.grey[800],
                    ),
                    children: [
                      TextSpan(
                        text: 'La primera calculadora, ',
                      ),
                      TextSpan(
                        text: 'Score MAMÁ,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2.0),
                      ),
                      TextSpan(
                        text: ' está basada en los lineamientos del protocolo ',
                      ),
                      TextSpan(
                        text: '“Score MAMÁ y claves obstétricas” ',
                        // style: TextStyle(
                        //     color: Theme.of(context).primaryColor,
                        //     fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'publicado por el '),
                      TextSpan(
                          text: 'Ministerio de Salud Pública del Ecuador ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text:
                            'en el año 2017, y tiene como objeto el acceso del personal de salud a esta herramienta de una manera fácil e intuitiva. Esta permite la estadificación del riesgo obstétrico para facilitar el manejo de las principales emergencias obstétricas, mediante la implementación de un sistema de respuesta rápida compuesto por claves: ',
                      ),
                      TextSpan(
                        text: ' roja, ',
                        style: TextStyle(
                          backgroundColor: Colors.red[50],
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' azul ',
                        style: TextStyle(
                            backgroundColor: Colors.blue[100],
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' y ',
                      ),
                      TextSpan(
                        text: ' amarilla. ',
                        style: TextStyle(
                          backgroundColor: Colors.yellow[50],
                          color: Colors.yellow[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Su propósito es agilizar y estandarizar lineamientos para la toma de decisiones en emergencias obstétricas, que conlleven a los criterios de manejo oportuno de las gestantes y puérperas, constituyendo un soporte permanente para el personal de salud que trabaja en la atención de este grupo poblacional en los establecimientos de salud de todos los niveles de atención del Sistema Nacional de Salud del Ecuador.',
                      ),
                    ]),
              ),
              SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 16.0,
                      color: Colors.grey[800],
                    ),
                    children: [
                      TextSpan(
                        text: 'La segunda calculadora, ',
                      ),
                      TextSpan(
                        text: 'Edad Gestacional,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2.0),
                      ),
                      TextSpan(
                        text:
                            ' es una pequeña herramienta que permite el cálculo rápido y fácil de dos factores importantes: la edad gestacional de las embarazadas, y la fecha probable de parto.',
                      ),
                    ]),
              ),
              SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 16.0,
                      color: Colors.grey[800],
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Calculadora Obstétrica es una aplicación desarrollada por médicos y diseñada para médicos, misma que se encuentra activamente en desarrollo, y próximamente se actualizará con más herramientas que faciliten las tareas de todo el personal de la salud.',
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
