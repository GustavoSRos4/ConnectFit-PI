import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/APIs/globals.dart';

class FetchProfissonais {
  static Future<List<Map<String, dynamic>>> fetchAllProfissionais() async {
    var url = Uri.parse('$baseURL/showAllProfissionais');
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
      List<dynamic> profissionaisList = data['PessoaProfissionais'];
      List<Map<String, dynamic>> profissionais = [];

      for (var profissionalData in profissionaisList) {
        //var medida = medidaData['Medida'];
        var profisionais = profissionalData['Profissional'];

        for (var profissional in profisionais) {
          profissionais.add({
            'User': profissional['User'],
            'PessoaProfissional': profissional['PessoaProfissional'],
            'Especialidades': profissional['Especialidades'],
          });
        }
      }

      return profissionais;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }

  static Future<Map<String, dynamic>> fetchProfissional(int id) async {
    var url = Uri.parse('$baseURL/showDataProfissional/$id');
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

      return data;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return {};
    }
  }
}
