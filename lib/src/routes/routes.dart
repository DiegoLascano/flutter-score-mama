import 'package:flutter/material.dart';

import 'package:calcu_obstetrica/src/pages/actions_page.dart';
import 'package:calcu_obstetrica/src/pages/home_page.dart';
import 'package:calcu_obstetrica/src/pages/about_page.dart';
import 'package:calcu_obstetrica/src/pages/navigation_page.dart';
import 'package:calcu_obstetrica/src/pages/score_mama_page.dart';
import 'package:calcu_obstetrica/src/pages/gestational_age_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    'about': (BuildContext context) => AboutPage(),
    'score_mama': (BuildContext context) => ScoreMama(),
    'actions': (BuildContext context) => ActionsPage(),
    'gestational_age': (BuildContext context) => GestationalAge(),
    'navigation_page': (BuildContext context) => NavigationPage(),
  };
}
