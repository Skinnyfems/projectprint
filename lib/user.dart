import 'dart:math';
import 'package:flutter/material.dart';
import 'package:projectprint/print_screen.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String nama = 'John Doe';
  String email = 'john.doe@example.com';

  // Fungsi untuk menghasilkan kode undangan acak
  String generateRandomCode() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  void _showInvitePopup() {
    final String randomCode = generateRandomCode();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invit User'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Code Invit:'),
              SizedBox(height: 8),
              Text(randomCode,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                print('Code Invit: $randomCode');
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PrintScreen(),
              ),
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Nama: $nama'),
            ),
            ListTile(
              title: Text('E-mail: $email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showInvitePopup,
              child: Text('Invit User'),
            ),
          ],
        ),
      ),
    );
  }
}
