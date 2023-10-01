import 'package:flutter/material.dart';
import 'package:projeto/Pages/HomePage/home.dart';
import 'package:projeto/Pages/RecoverPassword/recuperar_senha.dart';
import 'package:projeto/Pages/Shared/Widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureTextPassword = true;
  bool obscureTextPasswordConfirm = true;

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
                    "images/iconeApp.png",
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
                        const CustomTextField(
                          label: "Email",
                          icon: Icons.mail,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
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
                                  fontSize: 25,
                                ),
                              ),
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                )
                              },
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
                                ),
                                onPressed: () => {
                                  Navigator.pushNamed(context, '/registrar'),
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
