import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:score_mama/src/bloc/bloc_provider.dart';

import 'package:score_mama/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MaterialColor buttonTextColor = const MaterialColor(
    0xFF14919B,
    const <int, Color>{
      50: const Color(0xFF14919B),
      100: const Color(0xFF14919B),
      200: const Color(0xFF14919B),
      300: const Color(0xFF14919B),
      400: const Color(0xFF14919B),
      500: const Color(0xFF14919B),
      600: const Color(0xFF14919B),
      700: const Color(0xFF14919B),
      800: const Color(0xFF14919B),
      900: const Color(0xFF14919B),
    },
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('es', 'ES'),
        ],
        title: 'Score Mamá',
        initialRoute: 'navigation_page',
        routes: getApplicationRoutes(),
        theme: ThemeData(
          primaryColor: Color(0xFF14919B),
          accentColor: Color(0xFF14919B),
          primarySwatch: buttonTextColor,
          textTheme: TextTheme(
            title: TextStyle(
                color: Color(0xFF323F4B),
                // fontSize: 25.0,
                fontWeight: FontWeight.bold),
            subhead: TextStyle(
              color: Color(0xFF323F4B),
              // fontSize: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
