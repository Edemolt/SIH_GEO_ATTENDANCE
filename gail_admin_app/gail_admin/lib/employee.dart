import 'package:flutter/material.dart';

class EmployeePage extends StatelessWidget {
  final int index;

  const EmployeePage(this.index, {super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employye details'),
        ),
        body: Center(
          child: Text('The details page of employee $index'),
        ));
  }
}
