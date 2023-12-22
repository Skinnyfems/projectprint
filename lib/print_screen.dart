import 'package:flutter/material.dart';
import 'drawer.dart';
import 'suplier_page.dart';
import 'material_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

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

  String selectedWeightUnit = 'KG';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('PRINT'),
        centerTitle: true,
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
            _buildLogo(), // Pindahkan logo ke bawah tulisan 'PRINT'
            SizedBox(height: 20),
            _buildTextField(
              'Suplier',
              selectedSuplier,
              _pilihSuplier,
            ),
            SizedBox(height: 16),
            _buildTextField(
              'Material',
              selectedMaterial,
              _pilihMaterial,
            ),
            SizedBox(height: 16),
            _buildTextField(
              'Nomor Rec',
              noRecController.text,
              null,
              controller: noRecController,
            ),
            SizedBox(height: 16),
            _buildTextField(
              'Nomor Pol',
              noPolController.text,
              null,
              controller: noPolController,
            ),
            SizedBox(height: 16),
            _buildInputBerat('Bruto', brutoController),
            SizedBox(height: 16),
            _buildInputBerat('Tara', taraController),
            ElevatedButton(
              onPressed: () {
                cetakData();
              },
              child: Text('PRINT'),
            ),
            SizedBox(height: 16),
            _buildDataTerCetak(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MaterialPag()),
          );
        },
        label: Text('Cari', style: TextStyle(fontSize: 14)),
        tooltip: 'Search Printer',
        icon: Icon(Icons.search, size: 20),
      ),
      endDrawer: AppDrawer(),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/invoices.png',
          height: 130,
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String value, Function()? onTap,
      {TextEditingController? controller}) {
    return TextField(
      readOnly: onTap != null,
      onTap: onTap,
      controller: controller ?? TextEditingController(text: value),
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildInputBerat(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}')),
            ],
            decoration: InputDecoration(
              labelText: label,
            ),
          ),
        ),
        SizedBox(width: 8),
        DropdownButton<String>(
          value: selectedWeightUnit,
          onChanged: (String? newValue) {
            setState(() {
              selectedWeightUnit = newValue!;
            });
          },
          items: <String>['KG', 'G', 'Ton']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDataTerCetak() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'HASIL PRINT:\n$printedData',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  void _pilihSuplier() async {
    final result = await showSearch(
      context: context,
      delegate: _SuplierSearchDelegate(suplierList),
    );
    if (result != null) {
      setState(() {
        selectedSuplier = result;
      });
    }
  }

  void _pilihMaterial() async {
    final result = await showSearch(
      context: context,
      delegate: _MaterialSearchDelegate(materialList),
    );
    if (result != null) {
      setState(() {
        selectedMaterial = result;
      });
    }
  }

  void cetakData() {
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

    NumberFormat numberFormat = NumberFormat('#,##0.###');

    double brutoValue = (numberFormat.parse(bruto) as double).toDouble();
    double taraValue = (numberFormat.parse(tara) as double).toDouble();

    double nettoValue = brutoValue - taraValue;

    String weightUnit = selectedWeightUnit;

    String formattedBruto = numberFormat.format(brutoValue);
    String formattedTara = numberFormat.format(taraValue);
    String formattedNetto = numberFormat.format(nettoValue);

    // Bangun data yang akan dicetak
    String printedResult =
        'Suplier: $suplier\nMaterial: $material\nNomor Rec: $noRec\nNomor Pol: $noPol\nBruto: $formattedBruto $weightUnit\nTara: $formattedTara $weightUnit\nNetto: $formattedNetto $weightUnit';

    // Set state untuk memperbarui data yang dicetak
    setState(() {
      printedData = printedResult;
    });
  }

  void _tampilkanPesanError(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.deepOrange,
      ),
    );
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
          // Lakukan logika pencarian jika diperlukan
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
              child: Text('Tambah Suplier'),
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
          // Lakukan logika pencarian jika diperlukan
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
              child: Text('Tambah Material'),
            ),
          ),
        ),
      ],
    );
  }
}
