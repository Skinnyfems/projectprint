import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';

class PrinterSearcher {
  static Future<List<PrinterNetworkManager>> cariPrinter() async {
    try {
      final List<PrinterNetworkManager> printers =
          await PrinterNetworkManager.discoverPrinters(
        discoveryTimeout: Duration(seconds: 5),
        timeout: Duration(seconds: 2),
      );
      print(printers);
      return printers;
    } catch (e) {
      print('Error saat mencari printer: $e');
      return [];
    }
  }
}
