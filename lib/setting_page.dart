import 'package:flutter/material.dart';
import 'login_screen.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showExitConfirmation(context);
              },
              child: Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Keluar'),
          content: Text('Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup pop-up
              },
              child: Text('Tidak', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                // Hapus semua halaman dari tumpukan dan navigasi ke halaman login
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) =>
                      false, // Menghapus semua halaman yang ada di tumpukan
                );
              },
              child: Text('Ya', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
