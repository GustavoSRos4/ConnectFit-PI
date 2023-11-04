import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

class FetchData {
  //API PARA BUSCAR CIDADES
  static Future<Map<String, String>> fetchEstados() async {
    var url = Uri.parse('$baseURL/ufSexo');
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

      // Aqui você precisa converter a resposta para um mapa de nomes de estados para siglas
      // Isso depende do formato dos seus dados
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> ufList = data['Uf'];
      Map<String, String> estados = {
        for (var uf in ufList) uf['Descricao']: uf['SiglaUF']
      };

      return estados;
    } else {
      // Se houver um erro na requisição, trate-o aqui
      debugPrint('Erro na requisição: ${response.statusCode}');

      // Retorne um mapa vazio em caso de erro
      return {};
    }
  }

  //API PARA BUSCAR CIDADES
  static Future<List<Map<String, dynamic>>> fetchCidades(uf) async {
    var url = Uri.parse('$baseURL/$uf/cidades');
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
      List<dynamic> cityList = data['Cidades'];
      List<Map<String, dynamic>> cidades = cityList
          .map((cidade) => {
                'NomeCidade': cidade['NomeCidade'],
                'idCidade': cidade['idCidade'],
              })
          .toList();
      return cidades;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }

  static Future<List<Map<String, String>>> fetchSexo() async {
    var url = Uri.parse('$baseURL/ufSexo');
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

      // Aqui você precisa converter a resposta para um mapa de nomes de estados para siglas
      // Isso depende do formato dos seus dados
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> sexoList = data['Sexo'];
      List<Map<String, String>> sexos = [
        for (var sexo in sexoList)
          {'Sigla': sexo['Sigla'], 'Descricao': sexo['Descricao']}
      ];

      return sexos;
    } else {
      // Se houver um erro na requisição, trate-o aqui
      debugPrint('Erro na requisição: ${response.statusCode}');

      // Retorne um mapa vazio em caso de erro
      return [];
    }
  }
}
