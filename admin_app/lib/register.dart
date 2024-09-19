import 'package:flutter/material.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(80, 10, 80, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: 'Employee Name',
                  hintStyle: const TextStyle(
                    fontFamily: 'YatraOne',
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFEDE885),
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      name.clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Color(0xFFEDE885),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: 'Employee@gmail.com',
                  hintStyle: const TextStyle(
                    fontFamily: 'YatraOne',
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFEDE885),
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      email.clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Color(0xFFEDE885),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              child: TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    fontFamily: 'YatraOne',
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFEDE885),
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      pass.clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Color(0xFFEDE885),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDE885),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'QuickSandBold'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
