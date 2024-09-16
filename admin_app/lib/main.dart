import 'package:admin_app/history.dart';
import 'package:admin_app/map.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/register.dart';
import 'package:admin_app/login.dart';
import 'package:admin_app/manual_checkin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'QuickSandBold',
        scaffoldBackgroundColor: const Color(0xFF2E3414),
        primaryColor: const Color(0xFF797E44),

        //brightness: Brightness.dark,
      ),
      //darkTheme: ThemeData.dark(),
      initialRoute: 'login',
      routes: {
        'login': (context) => const MyLogin(),
        'map': (context) => const MapPage(), // MapPage route added here
        'register': (context) => const MyRegister(),
        'checkin': (context) => const MyCheckin(),
        'history': (context) => const MyHistory(),
      },
    );
  }
}
