import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.baseline,
          children: <Widget>[
            const Center(
              child: Text(
                'Adminstrator ',
                style: TextStyle(
                  fontFamily: 'YatraOne',
                  fontSize: 48,
                  color: Color(0xFFfff0d1),
                ),
              ),
            ),
            Card(
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintText: 'Admin@gmail.com',
                  hintStyle: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFfff0d1),
                    fontFamily: 'QuickSand',
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      email.clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Color(0xFFfff0d1),
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
                // Hides password input
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  hintStyle: const TextStyle(
                    color: Color(0xFFfff0d1),
                    fontFamily: 'QuickSand',
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      pass.clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Color(0xFFfff0d1),
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
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'details');
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Color(0xFFfff0d1),
                      fontFamily: 'QuickSand',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
