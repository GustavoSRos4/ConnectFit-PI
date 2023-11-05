import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/APIs/globals.dart';

class ApiMedidas {
  //API para primeria parte de ciração de conta
  static Future<http.Response> registrarMedidas(
    int peso,
    int percentualGordura,
    int subescapular,
    int triceps,
    int peitoral,
    int axilarMedia,
    int supraIliaca,
    int abdominal,
    int femuralMedia,
    List<Map<String, String>> areas,
  ) async {
    Map data = {
      "peso": peso,
      "percentualGordura": percentualGordura,
      "subescapular": subescapular,
      "triceps": triceps,
      "peitoral": peitoral,
      "axilarMedia": axilarMedia,
      "supraIliaca": supraIliaca,
      "abdominal": abdominal,
      "femuralMedia": femuralMedia,
      "areas": areas,
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
