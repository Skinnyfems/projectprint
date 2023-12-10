import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:flutter/services.dart';
import 'suplier_page.dart';
import 'material_page.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  final TextEditingController noRecController = TextEditingController();
  final TextEditingController noPolController = TextEditingController();
  final TextEditingController brutoController = TextEditingController();
  final TextEditingController taraController = TextEditingController();

  bool isWiFiConnected = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> suplierList = ['Suplier1', 'Suplier2', 'Suplier3'];
  List<String> materialList = ['Material1', 'Material2', 'Material3'];

  String selectedSuplier = '';
  String selectedMaterial = '';
  String printedData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Print'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              readOnly: true,
              onTap: () async {
                final result = await showSearch(
                  context: context,
                  delegate: _SuplierSearchDelegate(suplierList),
                );
                if (result != null) {
                  setState(() {
                    selectedSuplier = result;
                  });
                }
              },
              controller: TextEditingController(text: selectedSuplier),
              decoration: InputDecoration(labelText: 'Suplier'),
            ),
            SizedBox(height: 16),
            TextField(
              readOnly: true,
              onTap: () async {
                final result = await showSearch(
                  context: context,
                  delegate: _MaterialSearchDelegate(materialList),
                );
                if (result != null) {
                  setState(() {
                    selectedMaterial = result;
                  });
                }
              },
              controller: TextEditingController(text: selectedMaterial),
              decoration: InputDecoration(labelText: 'Material'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: noRecController,
              decoration: InputDecoration(labelText: 'Nomor Rec'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: noPolController,
              decoration: InputDecoration(labelText: 'Nomor Pol'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: brutoController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: 'Bruto'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: taraController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: 'Tara'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                printData();
              },
              child: Text('Print'),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Hasil Print:\n$printedData',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleConnection();
        },
        tooltip: 'Connect/Disconnect WiFi',
        child: Icon(Icons.wifi),
      ),
      endDrawer: AppDrawer(),
    );
  }

  void printData() {
    // Ambil data dari controller
    String suplier = selectedSuplier;
    String material = selectedMaterial;
    String noRec = noRecController.text;
    String noPol = noPolController.text;
    String bruto = brutoController.text;
    String tara = taraController.text;

    // Periksa jika salah satu dari kolom yang diperlukan kosong
    if (suplier.isEmpty ||
        material.isEmpty ||
        noRec.isEmpty ||
        noPol.isEmpty ||
        bruto.isEmpty ||
        tara.isEmpty) {
      _tampilkanPesanError("Data belum lengkap diisi");
      return;
    }

    // Konversi bruto dan tara ke tipe integer
    int brutoValue = int.tryParse(bruto) ?? 0;
    int taraValue = int.tryParse(tara) ?? 0;

    // Bangun data yang akan dicetak
    String printedResult =
        'Suplier: $suplier\nMaterial: $material\nNomor Rec: $noRec\nNomor Pol: $noPol\nBruto: $brutoValue\nTara: $taraValue';

    // Set state untuk memperbarui data yang dicetak
    setState(() {
      printedData = printedResult;
    });

    // Implementasikan logika untuk mengirim data melalui WiFi
    if (isWiFiConnected) {
      // Implementasikan logika untuk mengirim data ke perangkat WiFi yang terhubung
    } else {
      // Tangani kasus di mana WiFi tidak terhubung
    }
  }

  void _tampilkanPesanError(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _toggleConnection() {
    if (isWiFiConnected) {
      _disconnectFromWiFi();
    } else {
      _connectToWiFi();
    }
  }

  void _connectToWiFi() {
    setState(() {
      isWiFiConnected = true;
    });
  }

  void _disconnectFromWiFi() {
    setState(() {
      isWiFiConnected = false;
    });
  }
}

class _SuplierSearchDelegate extends SearchDelegate<String> {
  final List<String> suplierList;

  _SuplierSearchDelegate(this.suplierList);

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        fillColor: Colors.grey[200],
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // Perform search logic if needed
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? suplierList
        : suplierList
            .where((data) => data.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            ...suggestionList.map((result) {
              return ListTile(
                title: Text(result),
                onTap: () {
                  close(context, result);
                },
              );
            }),
          ],
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuplierPage()),
                );
              },
              child: Text('Cek Suplier'),
            ),
          ),
        ),
      ],
    );
  }
}

class _MaterialSearchDelegate extends SearchDelegate<String> {
  final List<String> materialList;

  _MaterialSearchDelegate(this.materialList);

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        fillColor: Colors.grey[200],
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // Perform search logic if needed
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? materialList
        : materialList
            .where((data) => data.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...suggestionList.map((result) {
              return ListTile(
                title: Text(result),
                onTap: () {
                  close(context, result);
                },
              );
            }),
          ],
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MaterialPag()),
                );
              },
              child: Text('Cek Material'),
            ),
          ),
        ),
      ],
    );
  }
}
