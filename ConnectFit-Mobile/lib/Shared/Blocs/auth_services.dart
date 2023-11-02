import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/globals.dart';

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
    String cpf,
    String dataNas,
    String ddd,
    String numeroTel,
    String logradouro,
    String numeroEnd,
    String complemento,
    String cep,
    String bairro,
  ) async {
    Map data = {
      "cpf": cpf,
      "dataNas": dataNas,
      "ddd": ddd,
      "numeroTele": numeroTel,
      "logradouro": logradouro,
      "numeroEnd": numeroEnd,
      "complemento": complemento,
      "cep": cep,
      "bairro": bairro,
    };
    var body = json.encode(data);
    var url = Uri.parse('$baseURL/criarPessoa'); //trocar pela rota do laravel
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    debugPrint(response.body);
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
