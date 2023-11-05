import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:projeto/Pages/RecoverPasswordPage/recuperar_senha.dart';
import 'package:projeto/Shared/Blocs/APIs/auth_services.dart';
import 'package:projeto/Shared/Blocs/APIs/globals.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureTextPassword = true;
  bool obscureTextPasswordConfirm = true;

  late String _email = "";
  late String _password = "";

  loginPressed() async {
    Navigator.pushNamed(context, '/home');
    /*
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (mounted) {
          Navigator.pushNamed(context, '/home');
        }
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first);
        }
      }
    } else {
      errorSnackBar(context, "Preencha todos os campos");
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.deepOrange,
            height: double.infinity,
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.pretoPag,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Container(
                height: 25,
                decoration: const BoxDecoration(
                  color: Colors.pretoPag,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: 128,
                  height: 128,
                  child: Image.asset(
                    "assets/images/iconeApp.png",
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              const SizedBox(
                height: 120,
                child: Text(
                  "ConnectFit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: Card(
                  color: Colors.begeclaro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 25,
                      right: 25,
                    ),
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          onChanged: (value) {
                            _email = value;
                          },
                          label: "Email",
                          icon: Icons.mail,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          onChanged: (value) {
                            _password = value;
                          },
                          label: "Senha",
                          icon: Icons.vpn_key,
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
                        ),
                        Container(
                          height: 40,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: const Text(
                              "Recuperar Senha",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RecuperarSenha(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: TextButton(
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () => loginPressed(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Não está cadastrado?"),
                              TextButton(
                                child: const Text(
                                  "Cadastre-se",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onPressed: () => {
                                  Navigator.pushNamed(context, '/register'),
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
