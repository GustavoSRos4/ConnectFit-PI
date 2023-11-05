import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

class FetchData {
  //API PARA BUSCAR ESTADOS
  static Future<List<Map<String, String>>> fetchEstados() async {
    var url = Uri.parse('$baseURL/ufSexo');
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
      List<dynamic> ufList = data['Uf'];
      List<Map<String, String>> estados = [
        for (var uf in ufList)
          {'SiglaUF': uf['SiglaUF'], 'Descricao': uf['Descricao']}
      ];
      return estados;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');

      return [];
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
      //debugPrint('Response data: ${response.body}');

      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> cityList = data['Cidades'];
      List<Map<String, dynamic>> cidadess = [
        for (var city in cityList)
          {'idCidade': city['idCidade'], 'NomeCidade': city['NomeCidade']}
      ];
      /*
      List<Map<String, dynamic>> cidades = cityList
          .map((cidade) => {
                'NomeCidade': cidade['NomeCidade'],
                'idCidade': cidade['idCidade'],
              })
          .toList();*/
      return cidadess;
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
      //debugPrint('Response data: ${response.body}');
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> sexoList = data['Sexo'];
      List<Map<String, String>> sexos = [
        for (var sexo in sexoList)
          {'Sigla': sexo['Sigla'], 'Descricao': sexo['Descricao']}
      ];

      return sexos;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }

  static Future<List<Map<String, String>>> fetchConsumoAlc() async {
    var url = Uri.parse('$baseURL/ufSexo');
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
      List<dynamic> sexoList = data['Sexo'];
      List<Map<String, String>> sexos = [
        for (var sexo in sexoList)
          {'Sigla': sexo['Sigla'], 'Descricao': sexo['Descricao']}
      ];

      return sexos;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }
}
