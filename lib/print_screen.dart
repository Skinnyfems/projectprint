import 'package:flutter/material.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  final TextEditingController suplierController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController noRecController = TextEditingController();
  final TextEditingController noPolController = TextEditingController();

  String printedData = ''; // State variable to hold printed data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print'),
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
              decoration: InputDecoration(labelText: 'No. Rec'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: noPolController,
              decoration: InputDecoration(labelText: 'No. Pol'),
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
              padding: EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Text(
                printedData,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void printData() {
    // Retrieve data from controllers
    String suplier = suplierController.text;
    String material = materialController.text;
    String noRec = noRecController.text;
    String noPol = noPolController.text;

    // Format the data for display
    String formattedData = 'Suplier: $suplier\n'
        'Material: $material\n'
        'No. Rek: $noRec\n'
        'No. Pol: $noPol';

    // Update the state variable
    setState(() {
      printedData = formattedData;
    });
  }
}
