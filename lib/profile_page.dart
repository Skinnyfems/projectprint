import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'print_screen.dart';
import "api_service.dart";

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Memuat data dari SharedPreferences saat widget diinisialisasi
    _loadUserData();
  }

  // Fungsi untuk memuat data pengguna dari SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Isi nilai awal untuk username dan email dari SharedPreferences
      _usernameController.text = prefs.getString('username') ?? 'JohnDoe';
      _emailController.text =
          prefs.getString('email') ?? 'john.doe@example.com';
    });
  }

  // Fungsi untuk menyimpan perubahan username dan email ke SharedPreferences
  Future<void> _saveChanges() async {
    String newUsername = _usernameController.text;
    String newEmail = _emailController.text;

    // Simpan perubahan ke SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
    await prefs.setString('email', newEmail);

    print('Perubahan Disimpan:');
    print('Username: $newUsername');
    print('Email: $newEmail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icon panah kembali
          onPressed: () {
            // Navigasi kembali ke halaman PrintScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PrintScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implementasi logika untuk menyimpan perubahan username dan email
                _saveChanges().then((_) {
                  // Tampilkan Snackbar ketika perubahan berhasil disimpan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data telah diubah'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                });
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }

  void someFunction() async {
    try {
      // Contoh penggunaan fungsi getProfile
      Map<String, dynamic> profileResponse = await getProfile('example_user');
      print(profileResponse);

      // Contoh penggunaan fungsi updateProfile
      Map<String, dynamic> updateProfileResponse = await updateProfile(
          'example_user', 'new_example_user', 'new_email@example.com');
      print(updateProfileResponse);
    } catch (e) {
      print('Error: $e');
    }
  }
}
