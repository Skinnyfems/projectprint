// import 'package:wifi_info_flutter/wifi_info_flutter.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:connectivity/connectivity.dart';

// Future<void> printToWifiPrinter() async {
//   final ConnectivityResult connectivityResult =
//       await Connectivity().checkConnectivity();

//   if (connectivityResult == ConnectivityResult.wifi) {
//     final wifiInfo = await WifiInfo().getWifiIP() ?? '';
//     print('Connected to WiFi. IP Address: $wifiInfo');

//     const String printerIp = '192.168.0.100'; // Ganti dengan alamat IP printer
//     const int printerPort = 9100; // Ganti dengan port printer

//     final profile = await CapabilityProfile.load();
//     final printer = NetworkPrinter(PaperSize.mm80, profile);

//     final PosPrintResult res =
//         await printer.connect('tcp', printerIp, printerPort);

//     if (res != PosPrintResult.success) {
//       print('Gagal terhubung ke printer: $res');
//       return;
//     }

//     // contoh:
//     printer.text('Hello, World!');
//     printer.cut();
//     printer.disconnect();
//   } else {
//     print('Tidak terhubung ke WiFi.');
//   }
// }
