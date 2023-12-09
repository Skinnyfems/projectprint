import 'package:flutter/material.dart';
import 'drawer.dart'; // Import file drawer.dart

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  final TextEditingController noRecController = TextEditingController();
  final TextEditingController noPolController = TextEditingController();

  bool isWiFiConnected = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> suplierList = [
    'Suplier1',
    'Suplier2',
    'Suplier3'
  ]; // Gantilah dengan data nyata
  List<String> materialList = [
    'Material1',
    'Material2',
    'Material3'
  ]; // Gantilah dengan data nyata

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
                  delegate: _DataSearchDelegate(suplierList),
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
                  delegate: _DataSearchDelegate(materialList),
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
              decoration: InputDecoration(labelText: 'Nomor Rekening'),
            ),
            SizedBox(height: 16),
            TextField(
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
    // Retrieve data from controllers
    String suplier = selectedSuplier;
    String material = selectedMaterial;
    String noRec = noRecController.text;
    String noPol = noPolController.text;

    // Construct the printed data
    String printedResult =
        'Suplier: $suplier\nMaterial: $material\nNomor Rekening: $noRec\nNomor Polisi: $noPol';

    // Set the state to update the printed data
    setState(() {
      printedData = printedResult;
    });

    // Implement logic to send data via WiFi
    if (isWiFiConnected) {
      // Implement logic to send data to the connected WiFi device
    } else {
      // Handle the case where WiFi is not connected
    }
  }

  void _toggleConnection() {
    if (isWiFiConnected) {
      // Disconnect from WiFi
      _disconnectFromWiFi();
    } else {
      // Connect to WiFi
      _connectToWiFi();
    }
  }

  void _connectToWiFi() {
    // Implement logic to connect to WiFi
    setState(() {
      isWiFiConnected = true;
    });
  }

  void _disconnectFromWiFi() {
    // Implement logic to disconnect from WiFi
    setState(() {
      isWiFiConnected = false;
    });
  }
}

class _DataSearchDelegate extends SearchDelegate<String> {
  final List<String> dataList;

  _DataSearchDelegate(this.dataList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
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
    // ... (implementasi hasil pencarian)
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? dataList
        : dataList
            .where((data) => data.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            close(context, suggestionList[index]);
          },
        );
      },
    );
  }
}
