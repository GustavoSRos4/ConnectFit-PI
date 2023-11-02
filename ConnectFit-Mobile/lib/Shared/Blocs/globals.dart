import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseURL = "http://10.0.2.2:8000/api"; //emulador localhost
const Map<String, String> headers = {"Content-Type": "application/json"};

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 1),
    ),
  );
}

Future<void> saveToken(String token) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  } catch (e) {
    debugPrint('Ocorreu um erro ao salvar o token: $e');
  }
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
