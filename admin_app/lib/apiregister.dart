import 'package:flutter/material.dart';
import 'apiservice.dart'; 

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final name = TextEditingController();
  final ApiService apiService = ApiService();

  void _register() async {
    try {
      final response = await apiService.register(email.text, pass.text, name.text);
      if (response['success']) {
        Navigator.pushNamed(context, 'login'); // Navigate to login on success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed')),
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
            controller: name,
            decoration: InputDecoration(hintText: 'Name'),
          ),
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
            onPressed: _register,
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
