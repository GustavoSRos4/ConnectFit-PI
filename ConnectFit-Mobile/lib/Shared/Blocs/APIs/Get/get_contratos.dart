import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

class FetchContratos {
  ///API para mostrar os contratos
  static Future<List<Map<String, dynamic>>> fetchContratos() async {
    var url = Uri.parse('$baseURL/mostrarContratos');
    String? token = await getToken();
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> contratosList = data['Contrato'];

      List<Map<String, dynamic>> contratos = [
        for (var contrato in contratosList)
          {
            'idPessoaProfissional': contrato['idPessoaProfissional'],
            'dataInic': contrato['dataInic'],
            'dataFinal': contrato['dataFinal'],
            'idDuracao': contrato['idDuracao'],
            'valor': contrato['valor'],
            'created_at': contrato['created_at'],
          }
      ];

      return contratos;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }
}
