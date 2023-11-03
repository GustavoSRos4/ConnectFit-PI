import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

class FetchData {
  //API PARA BUSCAR CIDADES
  static Future<List<String>> fetchEstados() async {
    var url = Uri.parse('$baseURL/ufSexo');
    String? token = await getToken();
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      debugPrint('Response data: ${response.body}');
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> ufList = data['Uf'];
      List<String> estados =
          ufList.map((uf) => uf['Descricao'] as String).toList();
      return estados;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }

  //API PARA BUSCAR CIDADES
  static Future<List<String>> fetchCidades() async {
    var url = Uri.parse('$baseURL/{MG}cidades');
    String? token = await getToken();
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Se a requisição for bem-sucedida, o código de status será 200
      debugPrint('Response data: ${response.body}');

      // Aqui você precisa converter a resposta para uma lista de strings
      // Isso depende do formato dos seus dados

      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> cityList = data['SiglaUF'];
      List<String> cidades =
          cityList.map((uf) => uf['Descricao'] as String).toList();

      return cidades;
    } else {
      // Se houver um erro na requisição, trate-o aqui
      debugPrint('Erro na requisição: ${response.statusCode}');

      // Retorne uma lista vazia em caso de erro
      return [];
    }
  }
}
