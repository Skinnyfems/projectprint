import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'print_screen.dart';

class MaterialPag extends StatefulWidget {
  @override
  _MaterialPageState createState() => _MaterialPageState();
}

class _MaterialPageState extends State<MaterialPag> {
  List<String> materialList = []; // Menyimpan data material

  TextEditingController _newMaterialController = TextEditingController();
  TextEditingController _editMaterialController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Memuat data material dari SharedPreferences saat widget diinisialisasi
    _loadMaterialData();
  }

  // Fungsi untuk memuat data material dari SharedPreferences
  Future<void> _loadMaterialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Isi nilai awal untuk daftar material dari SharedPreferences
      materialList = prefs.getStringList('materialList') ?? [];
    });
  }

  // Fungsi untuk menyimpan perubahan daftar material ke SharedPreferences
  Future<void> _saveMaterialChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('materialList', materialList);
  }

  // Fungsi untuk menambahkan material secara manual
  void _addMaterial() {
    String newMaterial = _newMaterialController.text;
    if (newMaterial.isNotEmpty) {
      setState(() {
        materialList.add(newMaterial);
        _saveMaterialChanges(); // Simpan perubahan ke SharedPreferences
      });
      _newMaterialController.clear();
    }
  }

  // Fungsi untuk menghapus material
  void _deleteMaterial(int index) {
    setState(() {
      materialList.removeAt(index);
      _saveMaterialChanges(); // Simpan perubahan ke SharedPreferences
    });
  }

  // Fungsi untuk mengedit nama material
  void _editMaterial(int index, String newMaterialName) {
    if (newMaterialName.isNotEmpty) {
      setState(() {
        materialList[index] = newMaterialName;
        _saveMaterialChanges(); // Simpan perubahan ke SharedPreferences
      });
    }
  }

  // Fungsi untuk menampilkan dialog pengeditan nama material
  void _showEditMaterialDialog(int index) {
    _editMaterialController.text = materialList[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Nama Material'),
          content: TextField(
            controller: _editMaterialController,
            decoration: InputDecoration(labelText: 'Nama Material Baru'),
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
                // Edit nama material
                _editMaterial(index, _editMaterialController.text);
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
        title: Text('Material'),
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
              controller: _newMaterialController,
              decoration: InputDecoration(labelText: 'Tambahkan Material Baru'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambahkan material baru ke dalam daftar
                _addMaterial();
              },
              child: Text('Tambahkan Material'),
            ),
            SizedBox(height: 16),
            Text(
              'Daftar Material:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: materialList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(materialList[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Tampilkan dialog untuk mengedit nama material
                            _showEditMaterialDialog(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Hapus material dari daftar
                            _deleteMaterial(index);
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
}
