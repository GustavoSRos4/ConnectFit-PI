import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/auth_services.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';

import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
import '../../../Shared/Blocs/APIs/globals.dart';

class OneLogin extends StatefulWidget {
  const OneLogin({super.key});

  @override
  State<OneLogin> createState() => _ThreePageState();
}

class _ThreePageState extends State<OneLogin> {
  final nomeEC = TextEditingController();
  final emailEC = TextEditingController();
  final senhaEC = TextEditingController();
  final confirmarSenhaEC = TextEditingController();
  var passwordCache = '';
  var passwordCacheConfirm = '';
  bool obscureTextPassword = true;
  bool obscureTextPasswordConfirm = true;

  stepOneCreateAccountPressed() async {
    debugPrint("DEu");
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailEC.text);
    if (emailValid) {
      http.Response response = await AuthServices.register(
        nomeEC.text,
        emailEC.text,
        senhaEC.text,
        confirmarSenhaEC.text,
      );
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        String token = responseMap['token'];
        await saveToken(token);
        if (mounted) {
          Navigator.pushNamed(context, '/twoDados');
        } else {
          if (mounted) {
            errorSnackBar(context, responseMap.values.first[0]);
          }
        }
      }
    } else {
      if (mounted) {
        errorSnackBar(context, 'email not valid');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    nomeEC.dispose();
    emailEC.dispose();
    senhaEC.dispose();
    confirmarSenhaEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: <Widget>[
          ListView(
            children: [
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: "Nome",
                        icon: Icons.person,
                        hint: "Digite seu nome...",
                        controller: nomeEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          if (text.length < 5) {
                            return "Esse campo precisa de mais de 5 letras. (Tem ${text.length})";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "E-mail",
                        icon: Icons.mail,
                        hint: "Digite seu e-mail...",
                        controller: emailEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          if (!isEmail(text)) {
                            return "Esse não é um e-mail válido!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Senha",
                        hint: "Digite sua senha...",
                        icon: Icons.vpn_key,
                        obscureTest: obscureTextPassword,
                        controller: senhaEC,
                        sufix: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureTextPassword = !obscureTextPassword;
                            });
                          },
                          icon: Icon(
                            obscureTextPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                        onChanged: (text) => passwordCache = text,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Confirmar Senha",
                        hint: "Confirme sua senha...",
                        icon: Icons.vpn_key,
                        obscureTest: obscureTextPasswordConfirm,
                        controller: confirmarSenhaEC,
                        onChanged: (text) => passwordCacheConfirm = text,
                        sufix: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureTextPasswordConfirm =
                                  !obscureTextPasswordConfirm;
                            });
                          },
                          icon: Icon(obscureTextPasswordConfirm
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          if (passwordCacheConfirm != passwordCache) {
                            return "As senhas não estão iguais!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      GlobalCustomElevatedButton(
                        borderRadius: 50,
                        width: double.infinity,
                        onPressed: () {
                          Navigator.pushNamed(context, '/twoDados');
                          stepOneCreateAccountPressed();
                        },
                        child: const CustomText(
                          text: "Cadastrar",
                          fontSize: 17,
                          isBold: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
