import 'package:flutter/material.dart';

import 'dart:ui';

class ResultsCard extends StatelessWidget {
  final Widget content;
  final String title;

  ResultsCard(this.content, this.title);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: _screenSize.width * 1.0,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              SizedBox(height: 10.0),
              content
            ],
          ),
        ),
      ),
    );
  }
}
