import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController inviteController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isInviteVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joined'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    // Toggle visibility of password
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: !_isPasswordVisible,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: inviteController,
              decoration: InputDecoration(
                labelText: 'Code Invit',
                suffixIcon: IconButton(
                  onPressed: () {
                    // Toggle visibility of invite code
                    setState(() {
                      _isInviteVisible = !_isInviteVisible;
                    });
                  },
                  icon: Icon(
                    _isInviteVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: !_isInviteVisible,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement registration logic here
                if (isValidRegistration()) {
                  navigateToLoginScreen(context);
                } else {
                  // Handle invalid registration
                  // You can show an error message or take other actions
                }
              },
              child: Text('Join'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidRegistration() {
    // Implement your registration validation logic here
    // For simplicity, we're assuming valid registration for any non-empty input
    return emailController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        inviteController.text.isNotEmpty;
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
