import 'package:flutter/material.dart';
import 'package:score_mama/src/bloc/score_mama_bloc.dart';
export 'package:score_mama/src/bloc/score_mama_bloc.dart';

class DataProvider extends InheritedWidget {
  final loginBloc = ScoreMamaBloc();

  DataProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ScoreMamaBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<DataProvider>())
        .loginBloc;
  }
}
