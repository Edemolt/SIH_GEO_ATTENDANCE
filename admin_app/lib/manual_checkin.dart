import 'package:flutter/material.dart';

class MyCheckin extends StatefulWidget {
  const MyCheckin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCheckinState createState() => _MyCheckinState();
}

class _MyCheckinState extends State<MyCheckin> {
  TimeOfDay _enterTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay _exitTime = const TimeOfDay(hour: 10, minute: 30);

  void _showEntryTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _enterTime = value!;
      });
    });
  }

  void _showExitTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _exitTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manual Check-In'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //display
                Text(
                  _enterTime.format(context).toString(),
                  style: const TextStyle(fontSize: 35),
                ),

                //butoon
                MaterialButton(
                  onPressed: _showEntryTimePicker,
                  color: Colors.green,
                  child: const Text('CHECK IN TIME'),
                ),
                const SizedBox(
                  height: 200,
                ),
                Text(
                  _exitTime.format(context).toString(),
                  style: const TextStyle(fontSize: 35),
                ),

                //butoon
                MaterialButton(
                  onPressed: _showExitTimePicker,
                  color: Colors.green,
                  child: const Text('CHECK OUT TIME'),
                ),
              ],
            ),
          ),
        ));
  }
}
