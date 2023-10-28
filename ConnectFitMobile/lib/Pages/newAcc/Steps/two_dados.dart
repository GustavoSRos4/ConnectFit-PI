import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:projeto/Shared/Models/login_model.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/positioned_float_action_button.dart';

class TwoDados extends StatefulWidget {
  const TwoDados({super.key});

  @override
  State<TwoDados> createState() => _OnePageState();
}

class _OnePageState extends State<TwoDados> {
  final cpfEC = TextEditingController();
  final dataNasEC = TextEditingController();
  final telefoneEC = TextEditingController();
  final cepEC = TextEditingController();
  final logradouroEC = TextEditingController();
  final numeroEC = TextEditingController();
  final cidadeEC = TextEditingController();
  final bairroEC = TextEditingController();
  final estadoEC = TextEditingController();
  String? selectedValue;
  List<String> dropdownItems = ["Masculino", "Feminino"];

  void getDados() {
    debugPrint("eita deu certo zé");
    var model = LoginModel(
      cpf: cpfEC.text,
      dataNas: dataNasEC.text,
      telefone: telefoneEC.text,
    );
    Navigator.pushNamed(context, '/two', arguments: model);
  }

  @override
  void dispose() {
    super.dispose();
    cpfEC.dispose();
    dataNasEC.dispose();
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
                        label: "CPF",
                        icon: Icons.credit_card,
                        hint: "Digite seu CPF...",
                        controller: cpfEC,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          if (!GetUtils.isCpf(text)) {
                            return "CPF invalido";
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
                              label: "Data de nascimento",
                              icon: Icons.calendar_month,
                              hint: "Digite sua data de Nascimento...",
                              controller: dataNasEC,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter(),
                              ],
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Esse campo não pode ficar vazio";
                                }
                                if (!GetUtils.isDateTime(text)) {
                                  return "Data Invalida";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(15),
                              value: selectedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: dropdownItems
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        value == 'Masculino'
                                            ? Icons.male
                                            : Icons.female,
                                      ),
                                      Text(value),
                                    ],
                                  ),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.brancoBege,
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(17),
                                labelText: 'Gênero',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Telefone",
                        icon: Icons.phone,
                        hint: "Digite seu telefone...",
                        controller: telefoneEC,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          if (!GetUtils.isPhoneNumber(text)) {
                            return "Telefone Inválido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          PositionedActionButton(onPressed: () {
            Navigator.pushNamed(context, '/threeInfos');
          }),
        ],
      ),
    );
  }
}
