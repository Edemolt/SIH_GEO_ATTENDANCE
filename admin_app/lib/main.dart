import 'package:admin_app/register.dart';
import 'package:flutter/material.dart';
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
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: 'login',
      routes: {
        'login': (context) => const MyLogin(),
        //'map': (context) => const MapPage(),
        'register': (context) => const MyRegister(),
        'checkin': (context) => const MyCheckin(),
      },
    );
  }
}
