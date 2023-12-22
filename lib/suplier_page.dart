import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'print_screen.dart';
import 'api_service.dart';

class SuplierPage extends StatefulWidget {
  @override
  _SuplierPageState createState() => _SuplierPageState();
}

class _SuplierPageState extends State<SuplierPage> {
  List<String> suplierList = []; // Menyimpan data suplier

  TextEditingController _newSuplierController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Memuat data suplier dari SharedPreferences saat widget diinisialisasi
    _loadSuplierData();
  }

  // Fungsi untuk memuat data suplier dari SharedPreferences
  Future<void> _loadSuplierData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Isi nilai awal untuk daftar suplier dari SharedPreferences
      suplierList = prefs.getStringList('suplierList') ?? [];
    });
  }

  // Fungsi untuk menyimpan perubahan daftar suplier ke SharedPreferences
  Future<void> _saveSuplierChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('suplierList', suplierList);
  }

  // Fungsi untuk menambahkan suplier dari PrintScreen
  void _addSuplierFromPrintScreen(String newSuplier) {
    if (newSuplier.isNotEmpty) {
      setState(() {
        suplierList.add(newSuplier);
        _saveSuplierChanges(); // Simpan perubahan ke SharedPreferences
      });
    }
  }

  // Fungsi untuk menambahkan suplier secara manual
  void _addSuplier() {
    String newSuplier = _newSuplierController.text;
    if (newSuplier.isNotEmpty) {
      setState(() {
        suplierList.add(newSuplier);
        _saveSuplierChanges(); // Simpan perubahan ke SharedPreferences
      });
      _newSuplierController.clear();
    }
  }

  // Fungsi untuk menghapus suplier
  void _deleteSuplier(int index) {
    setState(() {
      suplierList.removeAt(index);
      _saveSuplierChanges(); // Simpan perubahan ke SharedPreferences
    });
  }

  // Fungsi untuk mengedit nama suplier
  void _editSuplier(int index, String newSuplierName) {
    if (newSuplierName.isNotEmpty) {
      setState(() {
        suplierList[index] = newSuplierName;
        _saveSuplierChanges(); // Simpan perubahan ke SharedPreferences
      });
    }
  }

  // Fungsi untuk menampilkan dialog pengeditan nama suplier
  void _showEditSuplierDialog(int index) {
    TextEditingController _editSuplierController =
        TextEditingController(text: suplierList[index]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Nama Suplier'),
          content: TextField(
            controller: _editSuplierController,
            decoration: InputDecoration(labelText: 'Nama Suplier Baru'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Edit nama suplier
                _editSuplier(index, _editSuplierController.text);
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('Simpan'),
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
        title: Text('Suplier'),
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
            TextField(
              controller: _newSuplierController,
              decoration: InputDecoration(labelText: 'Tambahkan Suplier Baru'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambahkan suplier baru ke dalam daftar
                _addSuplier();
              },
              child: Text('Tambahkan Suplier'),
            ),
            SizedBox(height: 16),
            Text(
              'Daftar Suplier:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: suplierList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(suplierList[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Tampilkan dialog untuk mengedit nama suplier
                            _showEditSuplierDialog(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Hapus suplier dari daftar
                            _deleteSuplier(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void someFunction() async {
    try {
      // Contoh penggunaan fungsi getSuppliers
      List<Map<String, dynamic>> suppliers = await getSuppliers();
      print(suppliers);

      // Contoh penggunaan fungsi addSupplier
      Map<String, dynamic> newSupplier = await addSupplier('Supplier Baru');
      print(newSupplier);

      // Contoh penggunaan fungsi updateSupplier
      Map<String, dynamic> updatedSupplier =
          await updateSupplier(1, 'Supplier Baru Updated');
      print(updatedSupplier);

      // Contoh penggunaan fungsi deleteSupplier
      await deleteSupplier(1);
      print('Suplier berhasil dihapus');
    } catch (e) {
      print('Error: $e');
    }
  }
}
