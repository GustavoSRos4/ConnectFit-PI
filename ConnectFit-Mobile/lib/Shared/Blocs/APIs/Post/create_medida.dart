import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

class ApiMedidas {
  //API para registrar as medidas
  static Future<http.Response> registrarMedidas(
    List<Map<dynamic, dynamic>> areas,
  ) async {
    Map data = {
      "Areas": jsonEncode(areas),
    };
    var body = json.encode(data);
    var url = Uri.parse('$baseURL/createMedida'); //trocar pela rota do laravel
    String? token = await getToken();
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    debugPrint(response.body);
    return response;
  }
}
