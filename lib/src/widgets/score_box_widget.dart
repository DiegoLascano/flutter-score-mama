import 'package:flutter/material.dart';

import 'dart:ui';

class ScoreBox extends StatelessWidget {
  final int value;
  final String title;

  ScoreBox(this.value, this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.title.color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            color: Theme.of(context).textTheme.title.color,
          ),
        ),
      ],
    );
  }
}
