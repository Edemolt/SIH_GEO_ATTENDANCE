import 'package:flutter/material.dart';
import 'package:gail_admin/details.dart';
import 'package:gail_admin/login.dart';
//import 'package:gail_admin/mapp.dart';

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
        scaffoldBackgroundColor: const Color(0xFF3B3030),
        primaryColor: const Color(0xFF664343),
      ),
      //darkTheme: ThemeData.dark(),
      initialRoute: 'login',
      routes: {
        'login': (context) => const MyLogin(),
        'details': (context) => const MyDetails(),
        //'map': (context) => const MapPage(),
      },
    );
  }
}
