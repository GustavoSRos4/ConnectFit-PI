import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/Shared/Models/login_model.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/positioned_float_action_button.dart';

class TwoPage extends StatefulWidget {
  const TwoPage({super.key});

  @override
  State<TwoPage> createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  late LoginModel loginModel;
  final cepEC = TextEditingController();
  final logradouroEC = TextEditingController();
  final numeroEC = TextEditingController();
  final cidadeEC = TextEditingController();
  final bairroEC = TextEditingController();
  final estadoEC = TextEditingController();
  final paisEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loginModel = ModalRoute.of(context)?.settings.arguments as LoginModel;
    });
  }

  void getDados() {
    debugPrint("eita deu certo zé 2");
    var model = loginModel.copyWith(
      cep: cepEC.text,
      logradouro: logradouroEC.text,
      numero: numeroEC.text,
      cidade: cidadeEC.text,
      bairro: bairroEC.text,
      estado: estadoEC.text,
      pais: paisEC.text,
    );
    Navigator.pushNamed(context, '/three', arguments: model);
  }

  @override
  void dispose() {
    super.dispose();
    cepEC.dispose();
    logradouroEC.dispose();
    numeroEC.dispose();
    cidadeEC.dispose();
    bairroEC.dispose();
    estadoEC.dispose();
    paisEC.dispose();
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
                        label: "Logradouro",
                        icon: Icons.person,
                        hint: "Digite o logradouro...",
                        controller: logradouroEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "CEP",
                              icon: Icons.person,
                              hint: "Digite o CEP...",
                              controller: cepEC,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CepInputFormatter(),
                              ],
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Esse campo não pode ficar vazio";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomTextField(
                              label: "Numero",
                              icon: Icons.person,
                              hint: "Digite o numero...",
                              controller: numeroEC,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Esse campo não pode ficar vazio";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Cidade",
                        icon: Icons.person,
                        hint: "Digite a cidade...",
                        controller: cidadeEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Bairro",
                        icon: Icons.person,
                        hint: "Digite o bairro...",
                        controller: bairroEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Estado",
                        icon: Icons.person,
                        hint: "Digite o estado...",
                        controller: estadoEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "País",
                        icon: Icons.person,
                        hint: "Digite o país...",
                        controller: paisEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          PositionedActionButton(
            onPressed: getDados,
          ),
        ],
      ),
    );
  }
}
