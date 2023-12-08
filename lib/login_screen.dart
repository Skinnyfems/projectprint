import 'package:flutter/material.dart';
import 'print_screen.dart'; // Import file print_screen.dart

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement login logic here
                if (isValidCredentials()) {
                  navigateToPrintScreen(context);
                } else {
                  // Handle invalid credentials
                  // You can show an error message or take other actions
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidCredentials() {
    // Implement your login validation logic here
    // For simplicity, we're assuming valid credentials for any non-empty input
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void navigateToPrintScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PrintScreen()),
    );
  }
}
