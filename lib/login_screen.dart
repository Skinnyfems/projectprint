import 'package:flutter/material.dart';
import 'print_screen.dart';
import 'api_service.dart';

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrintScreen(),
                  ),
                );
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

  void isValidCredentials(BuildContext context) {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      login(usernameController.text, passwordController.text)
          .then((loginResponse) {
        // Periksa respon dari server backend
        if (loginResponse['success']) {
          // Login berhasil
          _navigateToPrintScreen(context);
        } else {
          // Tangani kegagalan login
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Kredensial Tidak Valid'),
                content:
                    Text('Silakan masukkan username dan password yang valid.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Tutup dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }).catchError((error) {
        // Tangani error dari login API
        print('Error: $error');
      });
    }
  }

  void _navigateToPrintScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PrintScreen()),
    );
  }

  void _resetPassword(BuildContext context) {
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
