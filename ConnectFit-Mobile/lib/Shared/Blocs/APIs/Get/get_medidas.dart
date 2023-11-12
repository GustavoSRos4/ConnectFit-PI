import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/APIs/globals.dart';

class FetchMedidas {
  static Future<List<Map<String, dynamic>>> fetchMedidas() async {
    var url = Uri.parse('$baseURL/mostrarPessoaUsuario');
    String? token = await getToken();
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      //debugPrint('Response data: ${response.body}');
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> fumanteList = data['Fumante'];
      List<Map<String, dynamic>> fumante = [
        for (var fumante in fumanteList)
          {'id': fumante['idFumante'], 'Descricao': fumante['Descricao']}
      ];

      return fumante;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }
}
