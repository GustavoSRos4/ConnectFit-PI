import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

class FetchDadosUsuario {
  ///API para buscar os dados do usuario
  static Future<Map<String, dynamic>> fetchDadosUsuario() async {
    var url = Uri.parse('$baseURL/mostrarPessoaUsuario');
    String? token = await getToken();
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> result = {
        'PessoaUsuario': data['PessoaUsuario'],
        'Medicamentos': parseMedicamentos(data['Medicamentos']),
        'Comorbidades': parseComorbidades(data['Comorbidades']),
      };

      return result;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return {};
    }
  }

  static List<Map<String, dynamic>> parseMedicamentos(
      List<dynamic> medicamentosList) {
    List<Map<String, dynamic>> medicamentos = [];

    for (var medicamentoData in medicamentosList) {
      for (var medicamento in medicamentoData) {
        medicamentos.add({
          'idMedicamento': medicamento['idMedicamento'],
          'descricao': medicamento['descricao'],
          'created_at': medicamento['created_at'],
        });
      }
    }

    return medicamentos;
  }

  static List<Map<String, dynamic>> parseComorbidades(
      List<dynamic> comorbidadesList) {
    List<Map<String, dynamic>> comorbidades = [];

    for (var comorbidadeData in comorbidadesList) {
      for (var comorbidade in comorbidadeData) {
        comorbidades.add({
          'idComorbidade': comorbidade['idComorbidade'],
          'descricao': comorbidade['descricao'],
          'created_at': comorbidade['created_at'],
        });
      }
    }

    return comorbidades;
  }
}
