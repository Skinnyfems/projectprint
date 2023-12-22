import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart' as esc;

class PrinterService {
  static Future<void> printToPrinter(String data) async {
    final profile = await CapabilityProfile.load();

    final printer = NetworkPrinter(PaperSize.mm80, profile);

    final PosPrintResult res =
        await printer.connect('192.168.1.100', port: 9100);

    if (res != PosPrintResult.success) {
      // Gagal terhubung ke printer
      print('Gagal terhubung ke printer');
      return;
    }

    // Gunakan metode writeBytes dari esc_pos_utils untuk mengirim perintah ESC/POS mentah
    printer.writeBytes(esc.encode(data));

    await printer.disconnect();
  }
}
