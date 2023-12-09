import 'package:flutter/material.dart';
import 'print_screen.dart';

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
                if (isValidCredentials()) {
                  _navigateToPrintScreen(context);
                } else {
                  // Handle invalid credentials
                  // You can show an error message or take other actions
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Credentials'),
                        content:
                            Text('Please enter valid username and password.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                _resetPassword(context);
              },
              child: Text('Forgot Password?'),
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

  void _navigateToPrintScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PrintScreen()),
    );
  }

  void _resetPassword(BuildContext context) {
    // Implement your password reset logic here
    // For simplicity, we'll just show a dialog with a message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Reset'),
          content: Text(
              'An email with password reset instructions has been sent to your registered email address.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
