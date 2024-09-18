import 'package:flutter/material.dart';
import 'apiservice.dart'; 

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginState createState() => _MyLoginState();
}
  

class _MyLoginState extends State<MyLogin> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final ApiService apiService = ApiService(); 
  // Function to handle login
  void _login() async {
    try {
      // Call the login API with email and password
      final response = await apiService.login(email.text, pass.text);

      if (response['success']) {
        // Navigate to the 'map' page if login is successful
        Navigator.pushNamed(context, 'map');
      } else {
        // Show error message if login fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } catch (e) {
      // Handle exceptions (e.g., network errors)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                'Hello Again! ',
                style: TextStyle(
                  fontFamily: 'YatraOne',
                  fontSize: 48,
                  color: Color(0xFFEDE885),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'Welcome Back, you\'ve been missed ',
                style: TextStyle(
                  fontFamily: 'YatraOne',
                  fontSize: 20,
                  color: Color(0xFFEDE885),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                    icon: const Icon(Icons.clear),
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
                obscureText: true, // Hides password input
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
                    icon: const Icon(Icons.clear),
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
                    // Ensure 'map' route is defined in your MaterialApp routes
                    Navigator.pushNamed(context, 'map');
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'QuickSandBold'),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDE885),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: const Text(
                    'Register',
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
