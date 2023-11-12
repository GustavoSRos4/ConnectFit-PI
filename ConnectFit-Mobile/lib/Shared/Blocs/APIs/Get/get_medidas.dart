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
      List<dynamic> medidasList = data['Medidas'];
      List<Map<String, dynamic>> medidas = [];

      for (var medidaData in medidasList) {
        //var medida = medidaData['Medida'];
        var areaMedidas = medidaData['AreaMedidas'];

        for (var areaMedida in areaMedidas) {
          medidas.add({
            'idArea': areaMedida['idArea'],
            'medida': areaMedida['Medida'],
            'created_at': areaMedida['created_at'],
          });
        }
      }

      return medidas;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }
}
