// Import libraries
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background color
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          // Center all elements vertically
          child: Column(
            // Arrange elements vertically
            mainAxisAlignment:
                MainAxisAlignment.center, // Center elements in the column
            children: <Widget>[
              // Text with Arabic text
              const Text(
                "OFF YABA", // Replace with your desired text
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0), // Add spacing
              // Login buttons
              Row(
                // Arrange buttons horizontally
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center buttons in the row
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: const Text('دخول كمستخدم'),
                  ),
                  const SizedBox(width: 20.0), // Add spacing between buttons
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      textStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: const Text('دخول كصاحب محل'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
