import 'package:flutter/material.dart';
import 'apiservice.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final ApiService apiService = ApiService(); // Initialize API Service

  void _login() async {
    try {
      final response = await apiService.login(email.text, pass.text);
      if (response['success']) {
        Navigator.pushNamed(context, 'map'); // Navigate to map on success
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: email,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: pass,
            decoration: InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: _login,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
