import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

Future<void> cetakStruk(String printedResult) async {
  const PaperSize ukuranKertas = PaperSize.mm80;
  final profil = await CapabilityProfile.load();
  final printer = NetworkPrinter(ukuranKertas, profil);

  try {
    final PosPrintResult hasilKoneksi =
        await printer.connect('192.168.0.123', port: 9100);

    if (hasilKoneksi == PosPrintResult.success) {
      ujiCetak(printer, printedResult);
    } else {
      print('Gagal terhubung ke printer. Periksa pengaturan koneksi.');
    }
  } catch (e) {
    print('Terjadi kesalahan selama proses pencetakan: $e');
  } finally {
    printer.disconnect();
  }
}

void ujiCetak(NetworkPrinter printer, String printedResult) {
  try {
    printer.text(printedResult);
    printer.cut();

    printer.feed(2);
  } catch (e) {
    print('Terjadi kesalahan selama proses pencetakan: $e');
  }
}
