import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

class FetchFichas {
  ///API para buscar as Fichas
  static Future<List<Map<String, dynamic>>> fetchFichas() async {
    var url = Uri.parse('$baseURL/showFicha');
    String? token = await getToken();
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> fichas = [];

      List<dynamic> fichasJson = jsonDecode(response.body)['Fichas'];

      for (var fichaJson in fichasJson) {
        Map<String, dynamic> ficha = {};
        ficha['Ficha'] = fichaJson['Ficha'];

        List<Map<String, dynamic>> treinos = [];
        for (var treinoJson in fichaJson['Treinos']) {
          Map<String, dynamic> treino = {};
          treino['Treino'] = treinoJson['Treino'];

          List<Map<String, dynamic>> exercicios = [];
          for (var exercicioJson in treinoJson['Exercicios']) {
            exercicios.add(exercicioJson);
          }

          treino['Exercicios'] = exercicios;
          treinos.add(treino);
        }

        ficha['Treinos'] = treinos;
        fichas.add(ficha);
      }

      return fichas;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }

  static Future<List<dynamic>> fetchExercicio() async {
    var url = Uri.parse('$baseURL/showExercicio');
    String? token = await getToken();
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> exercicios = jsonDecode(response.body)['Exercicios'];

      return exercicios;
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return [];
    }
  }
}
