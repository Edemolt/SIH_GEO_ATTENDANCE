import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFCB80AB),
              Color(0xFFE6D9A2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Center(
                child: Text(
                  'Administrator',
                  style: TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 48,
                    color: Color(0xFFfff0d1),
                    shadows: [
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: Colors.black38,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Email TextField
              _buildTextField(
                controller: email,
                hintText: 'Admin@gmail.com',
                icon: Icons.email,
                context: context,
              ),
              const SizedBox(height: 15),
              // Password TextField
              _buildTextField(
                controller: pass,
                hintText: 'Password',
                icon: Icons.lock,
                obscureText: true,
                context: context,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: const Color(0xFFCB80AB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.black38,
                  elevation: 10,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'details');
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    color: Color(0xFFE6D9A2),
                    fontFamily: 'QuickSand',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required BuildContext context,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 16.0,
          color: Color(0xFFE6D9A2),
          fontFamily: 'QuickSand',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15.0,
            color: Color(0xFFE6D9A2),
            fontFamily: 'QuickSand',
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFE6D9A2),
          ),
          filled: true,
          fillColor: Theme.of(context).primaryColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(color: Color(0xFFE6D9A2), width: 2),
          ),
        ),
      ),
    );
  }
}
