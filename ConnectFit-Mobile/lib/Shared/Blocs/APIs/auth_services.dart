import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/APIs/globals.dart';

class AuthServices {
  //API para primeria parte de ciração de conta
  static Future<http.Response> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword
    };
    var body = json.encode(data);
    var url =
        Uri.parse('$baseURL/registrarUsuario'); //trocar pela rota do laravel
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    debugPrint(response.body);
    return response;
  }

  //API para a segunda parte de criação de conta
  static Future<http.Response> registerTwo(
      int cpf,
      String dataNas,
      int ddd,
      int numeroTel,
      String logradouro,
      String numeroEnd,
      String complemento,
      int cep,
      String bairro,
      int idCidade,
      String siglaSexo) async {
    Map data = {
      "cpf": cpf,
      "dataNas": dataNas,
      "ddd": ddd,
      "numeroTel": numeroTel,
      "logradouro": logradouro,
      "numeroEnd": numeroEnd,
      "complemento": complemento,
      "cep": cep,
      "bairro": bairro,
      "idCidade": idCidade,
      'SiglaSexo': siglaSexo,
    };
    var body = json.encode(data);
    var url = Uri.parse('$baseURL/criarPessoa'); //trocar pela rota do laravel
    String? token = await getToken();
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    debugPrint(response.body);
    return response;
  }

  //API para a segunda parte de criação de conta
  static Future<http.Response> registerThree(
    int altura,
    int idFumante,
    int idNivelAtiFis,
    int idObjetivo,
    int idConsumoAlc,
    List<Map<String, String>> medicamentos,
    List<Map<String, String>> comorbidades,
  ) async {
    Map data = {
      "altura": altura,
      "idFumante": idFumante,
      "idNivelAtiFis": idNivelAtiFis,
      "idObjetivo": idObjetivo,
      "idConsumoAlc": idConsumoAlc,
      "Medicamentos": jsonEncode(medicamentos),
      "Comorbidades": jsonEncode(comorbidades),
    };
    debugPrint('$data');
    var body = json.encode(data);
    var url =
        Uri.parse('$baseURL/createPessoaUsuario'); //trocar pela rota do laravel
    String? token = await getToken();
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    debugPrint('teste ${response.body}');
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('$baseURL/login'); //trocar pela rota do laravel
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    debugPrint(response.body);
    return response;
  }
}
