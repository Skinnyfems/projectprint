import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF5C0087),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 255, 255, 255), // Warna latar belakang
              borderRadius: BorderRadius.circular(20.0), // Radius border
            ),
            padding: const EdgeInsets.all(16.0),
            child: const MyFormWidget(),
          ),
        ),
      ),
    );
  }
}

class MyFormWidget extends StatefulWidget {
  const MyFormWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFormWidgetState createState() => _MyFormWidgetState();
}

class _MyFormWidgetState extends State<MyFormWidget> {
  // Controller untuk mengontrol nilai di dalam TextField
  TextEditingController suplierController = TextEditingController();
  TextEditingController materialController = TextEditingController();
  TextEditingController no_recController = TextEditingController();
  TextEditingController no_polController = TextEditingController();

  String resultText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: suplierController,
            decoration: const InputDecoration(
                labelText: 'Suplier',
                labelStyle: TextStyle(
                  fontSize: 20,
                )),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: materialController,
            decoration: const InputDecoration(
                labelText: 'Material',
                labelStyle: TextStyle(
                  fontSize: 20,
                )),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: no_recController,
            decoration: const InputDecoration(
                labelText: 'No.Rec',
                labelStyle: TextStyle(
                  fontSize: 20,
                )),
            keyboardType: TextInputType.number, // Tampilkan keyboard numerik
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: no_polController,
            decoration: const InputDecoration(
                labelText: 'No.Pol',
                labelStyle: TextStyle(
                  fontSize: 20,
                )),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Akses nilai dari controller
              String suplier = suplierController.text;
              String material = materialController.text;
              int rec = int.tryParse(no_recController.text) ?? 0;
              String pol = no_polController.text;

              // Lakukan sesuatu dengan data yang diambil
              print('Suplier: $suplier');
              print('Material: $material');
              print('No.Rec: $rec');
              print('No.Pol: $pol');

              setState(() {
                resultText = '''
                  Suplier: $suplier
                  Material: $material
                  No.Rec: $rec
                  No.Pol: $pol
                ''';
              });
            },
            child: const Text('Print'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              print("CONNECT BERHASIL");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Warna hijau
              textStyle: const TextStyle(fontSize: 16.0),
            ),
            child: const Text('PRINTER CONNECT'),
          ),
          const SizedBox(height: 32.0),
          const SizedBox(height: 16.0),
          Text(
            resultText,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Pastikan untuk membuang controller ketika widget dihapus
    suplierController.dispose();
    materialController.dispose();
    no_recController.dispose();
    no_polController.dispose();
    super.dispose();
  }
}
