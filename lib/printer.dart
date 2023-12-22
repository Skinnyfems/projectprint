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
      // Menggunakan printedResult sebagai parameter
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

// Modifikasi fungsi ujiCetak untuk menerima parameter
void ujiCetak(NetworkPrinter printer, String printedResult) {
  try {
    // Menggunakan printedResult sebagai konten struk
    printer.text(printedResult);
    // Tambahkan konten struk lainnya sesuai kebutuhan
  } catch (e) {
    print('Terjadi kesalahan selama proses pencetakan: $e');
  }
}
