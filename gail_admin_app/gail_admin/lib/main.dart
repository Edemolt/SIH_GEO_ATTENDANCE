import 'package:flutter/material.dart';
import 'package:gail_admin/details.dart';
import 'package:gail_admin/leave.dart';
import 'package:gail_admin/login.dart';
import 'package:gail_admin/mapp.dart';

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
        scaffoldBackgroundColor: const Color(0xFF624E88),
        primaryColor: const Color(0xFF8967B3),
      ),
      initialRoute: 'login',
      routes: {
        'login': (context) => const MyLogin(),
        'details': (context) => const MyDetails(),
        'employee_list': (context) => const MyDetails(),
        'map': (context) => const MyMapPage(0),
        'leave': (context) => const LeavePage(0),
      },
    );
  }
}
