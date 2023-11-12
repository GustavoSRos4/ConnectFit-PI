/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/APIs/globals.dart';

class PessoaUsuario {
  final int idPessoaUsuario;
  final double altura;
  final int idFumante;
  final int idNivelAtiFis;
  final int idObjetivo;
  final int idConsumoAlc;

  PessoaUsuario({
    required this.idPessoaUsuario,
    required this.altura,
    required this.idFumante,
    required this.idNivelAtiFis,
    required this.idObjetivo,
    required this.idConsumoAlc,
  });

  factory PessoaUsuario.fromJson(Map<String, dynamic> json) {
    return PessoaUsuario(
      idPessoaUsuario: json['idPessoaUsuario'],
      altura: json['Altura'],
      idFumante: json['idFumante'],
      idNivelAtiFis: json['idNivelAtiFis'],
      idObjetivo: json['idObjetivo'],
      idConsumoAlc: json['idConsumoAlc'],
    );
  }
}

class Medicamento {
  final int idMedicamento;
  final String descricao;

  Medicamento({
    required this.idMedicamento,
    required this.descricao,
  });

  factory Medicamento.fromJson(Map<String, dynamic> json) {
    return Medicamento(
      idMedicamento: json['idMedicamento'],
      descricao: json['descricao'],
    );
  }
}

class Comorbidade {
  final int idComorbidade;
  final String descricao;

  Comorbidade({
    required this.idComorbidade,
    required this.descricao,
  });

  factory Comorbidade.fromJson(Map<String, dynamic> json) {
    return Comorbidade(
      idComorbidade: json['idComorbidade'],
      descricao: json['descricao'],
    );
  }
}

class FetchDadosUsuario {
  static Future<Map<String, dynamic>> fetchDadosUsuario() async {
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
      debugPrint(data.toString());
      // Convertendo os dados usando as classes criadas
      PessoaUsuario pessoaUsuario =
          PessoaUsuario.fromJson(data['PessoaUsuario']);
      debugPrint(pessoaUsuario.toString());

      List<List<Map<String, dynamic>>> medicamentosList =
          List<List<Map<String, dynamic>>>.from(data['Medicamentos']);

      List<List<Map<String, dynamic>>> comorbidadesList =
          List<List<Map<String, dynamic>>>.from(data['Comorbidades']);

      List<Medicamento> medicamentos = medicamentosList
          .expand((list) => list.map((item) => Medicamento.fromJson(item)))
          .toList();

      List<Comorbidade> comorbidades = comorbidadesList
          .expand((list) => list.map((item) => Comorbidade.fromJson(item)))
          .toList();

      // Aqui você tem acesso aos objetos pessoaUsuario, medicamentos e comorbidades
      // Faça o que precisar com esses dados

      return {
        'PessoaUsuario': pessoaUsuario,
        'Medicamentos': medicamentos,
        'Comorbidades': comorbidades,
      };
    } else {
      debugPrint('Erro na requisição: ${response.statusCode}');
      return {};
    }
  }
}
*/