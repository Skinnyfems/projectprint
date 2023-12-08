import 'package:flutter/material.dart';
import 'drawer.dart'; // Import file drawer.dart
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  final TextEditingController suplierController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController noRecController = TextEditingController();
  final TextEditingController noPolController = TextEditingController();

  bool isBluetoothConnected = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Tambahkan kunci ini ke Scaffold
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
            TextFormField(
              controller: suplierController,
              decoration: InputDecoration(labelText: 'Suplier'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: materialController,
              decoration: InputDecoration(labelText: 'Material'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: noRecController,
              decoration: InputDecoration(labelText: 'Nomor Rekening'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: noPolController,
              decoration: InputDecoration(labelText: 'Nomor Polisi'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement print logic here
                printData();
              },
              child: Text('Print'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleBluetoothConnection();
        },
        tooltip: 'Connect/Disconnect Bluetooth',
        child: Icon(Icons.bluetooth),
      ),
      endDrawer: AppDrawer(), // Gunakan AppDrawer di sini
    );
  }

  Future<void> _getBondedDevices() async {
    try {
      List<BluetoothDevice> devices =
          await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {
        _devices = devices;
      });

      _showDeviceSelectionDialog();
    } catch (e) {
      print('Error fetching bonded devices: $e');
    }
  }

  Future<void> _startBluetoothDiscovery() async {
    await FlutterBluetoothSerial.instance.cancelDiscovery();
    _devices.clear();

    try {
      FlutterBluetoothSerial.instance
          .startDiscovery()
          .listen((BluetoothDiscoveryResult result) {
        setState(() {
          _devices.add(result.device);
        });
      });
    } catch (e) {
      print('Error starting Bluetooth discovery: $e');
    }

    _showDeviceSelectionDialog();
  }

  Future<void> _showDeviceSelectionDialog() async {
    await FlutterBluetoothSerial.instance.cancelDiscovery();
    _devices.clear();

    try {
      final List<BluetoothDevice> devices =
          await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {
        _devices = devices;
      });
    } catch (e) {
      print('Error fetching bonded devices: $e');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Bluetooth Device'),
          content: Column(
            children: [
              if (_devices.isEmpty)
                Text('No bonded Bluetooth devices found.')
              else
                for (var device in _devices)
                  ListTile(
                    title: Text(device.name ?? 'Unknown Device'),
                    subtitle: Text(device.address),
                    onTap: () {
                      Navigator.of(context).pop();
                      _connectToDevice(device);
                    },
                  ),
            ],
          ),
        );
      },
    );
  }

  void printData() {
    // Retrieve data from controllers
    String suplier = suplierController.text;
    String material = materialController.text;
    String noRec = noRecController.text;
    String noPol = noPolController.text;

    // Implement logic to print data
    print('Suplier: $suplier');
    print('Material: $material');
    print('Nomor Rekening: $noRec');
    print('Nomor Polisi: $noPol');

    // Implement logic to send data to the connected Bluetooth device
    if (isBluetoothConnected &&
        _connection != null &&
        _connection!.isConnected) {
      String dataToPrint = 'YourDataToPrint';
      Uint8List uint8List = Uint8List.fromList(dataToPrint.codeUnits);
      _connection!.output.add(uint8List);
      _connection!.output.allSent.then((_) {
        // Do something after data is sent
      });
    } else {
      // Handle the case where Bluetooth is not connected or connection is null
    }
  }

  void _toggleBluetoothConnection() {
    if (isBluetoothConnected) {
      // Disconnect from Bluetooth
      _disconnectFromBluetooth();
    } else {
      // Connect to Bluetooth
      _showDeviceSelectionDialog();
    }
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      _connection = await BluetoothConnection.toAddress(device.address);
      setState(() {
        isBluetoothConnected = true;
      });
    } catch (e) {
      // Handle connection error
      print('Error connecting to device: $e');
    }
  }

  void _disconnectFromBluetooth() {
    if (_connection != null) {
      _connection!.dispose();
      setState(() {
        isBluetoothConnected = false;
      });
    }
  }
}
