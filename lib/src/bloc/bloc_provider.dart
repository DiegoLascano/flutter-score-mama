import 'package:flutter/material.dart';
import 'package:score_mama/src/bloc/score_mama_bloc.dart';
export 'package:score_mama/src/bloc/score_mama_bloc.dart';

class BlocProvider extends InheritedWidget {
  final loginBloc = ScoreMamaBloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ScoreMamaBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BlocProvider>())
        .loginBloc;
  }
}
