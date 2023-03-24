import 'package:flutter/material.dart';

class ThemeApp {
  static final Theme_App = ThemeData(
    primarySwatch: Colors.green,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(6, 87, 96, 1),
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontSize: 25,
        fontFamily: 'quran',
        color: const Color.fromRGBO(254, 249, 205, 1),
        shadows: [
          Shadow(
            blurRadius: 1.0,
            offset: Offset(.5, .5),
            color: Color.fromRGBO(6, 87, 96, 1),
          )
        ],
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontFamily: 'quran',
        color: const Color.fromRGBO(254, 249, 205, 1),
        shadows: [
          Shadow(
            blurRadius: 1.0,
            offset: Offset(.5, .5),
            color: Color.fromRGBO(6, 87, 96, 1),
          )
        ],
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: const Color.fromRGBO(6, 87, 96, 1),
      backgroundColor: const Color.fromRGBO(254, 249, 205, 1),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: const Color.fromRGBO(254, 249, 205, 1),
    ),
  );
}
