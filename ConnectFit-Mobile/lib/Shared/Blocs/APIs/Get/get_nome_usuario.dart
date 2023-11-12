import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/APIs/globals.dart';

class FetchNomeUsuario {
  static Future<String> fetchNomeUsuario() async {
    var url = Uri.parse('$baseURL/mostrarPessoa');
    String? token = await getToken();
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> userData = data['user'];

      // Obtendo o nome do usuário
      String nomeUsuario = userData['name'];

      return nomeUsuario;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      // Retorne um valor padrão ou trate o erro conforme necessário
      return '';
    }
  }
}
