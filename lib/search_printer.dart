import 'dart:io';

Future<String> getIPAddress() async {
  try {
    // Mendapatkan daftar antarmuka jaringan
    List<NetworkInterface> interfaces = await NetworkInterface.list();

    // Cari antarmuka yang bukan loopback dan memiliki alamat IPv4
    for (NetworkInterface interface in interfaces) {
      if (interface.addresses.isNotEmpty) {
        for (InternetAddress address in interface.addresses) {
          if (address.type == InternetAddressType.IPv4) {
            return address.address;
          }
        }
      }
    }
  } catch (e) {
    print('Error getting IP address: $e');
  }

  return 'Unknown';
}

List<List<String>> generateIPRange(String currentIP) {
  List<List<String>> ipList = [];

  for (int i = 0; i <= 255; i++) {
    String targetIP =
        currentIP.substring(0, currentIP.lastIndexOf('.') + 1) + i.toString();

    List<String> separatedIP = targetIP.split('.');
    ipList.add(separatedIP);
  }

  return ipList;
}

Future<bool> checkOpenPort(String ipAddress, int port) async {
  try {
    final socket = await Socket.connect(ipAddress, port);
    await socket.close();
    return true;
  } catch (e) {
    return false;
  }
}
