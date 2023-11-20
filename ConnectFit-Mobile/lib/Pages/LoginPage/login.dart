import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:projeto/Pages/RecoverPasswordPage/recuperar_senha.dart';
import 'package:projeto/Shared/Blocs/APIs/Post/auth_services.dart';
import 'package:projeto/Shared/Blocs/globals.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureTextPassword = true;
  bool obscureTextPasswordConfirm = true;
  final emailEC = TextEditingController();
  final senhaEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  loginPressed() async {
    http.Response response = await AuthServices.login(
      emailEC.text,
      senhaEC.text,
    );
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      String token = responseMap['token'];
      await saveToken(token);
      if (mounted) {
        Navigator.pushNamed(context, '/home');
      }
    } else {
      if (mounted) {
        errorSnackBar(context, responseMap.values.first);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.grey[800],
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
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 25,
                        right: 25,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
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
                              autovalidateMode: AutovalidateMode.disabled,
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
                            ),
                            Container(
                              height: 40,
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                child: const CustomText(
                                  text: "Recuperar Senha",
                                  decoration: TextDecoration.underline,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RecuperarSenha(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GlobalCustomElevatedButton(
                              height: 60,
                              borderRadius: 50,
                              width: double.infinity,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  loginPressed();
                                } else {
                                  errorSnackBar(context,
                                      'Por favor, preencha os campos corretamente!');
                                }
                              },
                              child: const CustomText(
                                text: "Login",
                                fontSize: 17,
                                isBold: true,
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
                                  const CustomText(
                                      text: "Não está cadastrado?"),
                                  TextButton(
                                    child: const CustomText(
                                      color: Colors.deepOrange,
                                      text: "Cadastre-se",
                                      decoration: TextDecoration.underline,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
