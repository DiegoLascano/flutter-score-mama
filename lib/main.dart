import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:calcu_obstetrica/src/bloc/bloc_provider.dart';

import 'package:calcu_obstetrica/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MaterialColor mainSplash = const MaterialColor(
    0xFF079A82,
    const <int, Color>{
      50: const Color(0xFFF0FCF9),
      100: const Color(0xFFC6F7E9),
      200: const Color(0xFF8EEDD1),
      300: const Color(0xFF5FE3C0),
      400: const Color(0xFF2DCCA7),
      500: const Color(0xFF17B897),
      600: const Color(0xFF079A82),
      700: const Color(0xFF048271),
      800: const Color(0xFF016457),
      900: const Color(0xFF004440),
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
          primaryColor: mainSplash[600],
          accentColor: mainSplash[600],
          primarySwatch: mainSplash,
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
