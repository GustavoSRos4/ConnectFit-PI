import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

class Contratos {
  ///API para criar o contrato
  static Future<http.Response> criarContrato(
    int idPessoaProfissional,
    int idDuracao,
  ) async {
    Map data = {
      "idPessoaProfissional": idPessoaProfissional,
      "idDuracao": idDuracao,
    };
    var body = json.encode(data);
    var url =
        Uri.parse('$baseURL/createContrato'); //trocar pela rota do laravel
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
