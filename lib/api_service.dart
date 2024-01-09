import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://127.0.0.1:5000';

Future<List<Map<String, dynamic>>> getMaterials() async {
  final response = await http.get(
    Uri.parse('$baseUrl/material_page'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  } else {
    throw Exception('Gagal mengambil data material');
  }
}

Future<Map<String, dynamic>> addMaterial(String name) async {
  final response = await http.post(
    Uri.parse('$baseUrl/material_page'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': name}),
  );

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal menambahkan material');
  }
}

Future<Map<String, dynamic>> updateMaterial(
    int materialId, String newName) async {
  final response = await http.put(
    Uri.parse('$baseUrl/material_page$materialId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'new_name': newName}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal memperbarui material');
  }
}

Future<void> deleteMaterial(int materialId) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/material_page$materialId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode != 204) {
    throw Exception('Gagal menghapus material');
  }
}

Future<List<Map<String, dynamic>>> getSuppliers() async {
  final response = await http.get(
    Uri.parse('$baseUrl/suplier_page'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  } else {
    throw Exception('Gagal mengambil data suplier');
  }
}

Future<Map<String, dynamic>> addSupplier(String name) async {
  final response = await http.post(
    Uri.parse('$baseUrl/suplier_page'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': name}),
  );

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal menambahkan suplier');
  }
}

Future<Map<String, dynamic>> updateSupplier(
    int supplierId, String newName) async {
  final response = await http.put(
    Uri.parse('$baseUrl/suplier_page$supplierId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'new_name': newName}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal memperbarui suplier');
  }
}

Future<void> deleteSupplier(int supplierId) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/suplier_page$supplierId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode != 204) {
    throw Exception('Gagal menghapus suplier');
  }
}

Future<Map<String, dynamic>> getProfile(String username) async {
  final response = await http.get(
    Uri.parse('$baseUrl/profile_page?username=$username'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal mengambil profil');
  }
}

Future<Map<String, dynamic>> updateProfile(
    String username, String newUsername, String newEmail) async {
  final response = await http.put(
    Uri.parse('$baseUrl/profile_page?username=$username'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'new_username': newUsername,
      'new_email': newEmail,
    }),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal memperbarui profil');
  }
}

Future<Map<String, dynamic>> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal login');
  }
}

Future<Map<String, dynamic>> register(String username, String password,
    String email, String fullName, String codeInvit) async {
  final response = await http.post(
    Uri.parse('$baseUrl/register_screen'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
      'email': email,
      'full_name': fullName,
      'code_invit': codeInvit,
    }),
  );

  if (response.statusCode == 201) {
    return json.decode(response.body);
  } else {
    throw Exception('Gagal registrasi');
  }
}
