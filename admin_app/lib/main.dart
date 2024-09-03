import 'package:flutter/material.dart';
import 'package:admin_app/login.dart';
import 'package:admin_app/Pages/map_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => const MyLogin(),
        'map': (context) => const MapPage(),
      },
    ),
  );
}
