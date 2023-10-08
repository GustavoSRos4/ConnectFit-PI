import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:projeto/Pages/Shared/Models/login_model.dart';
import 'package:projeto/Pages/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Pages/Shared/Widgets/positioned_float_action_button.dart';

class OnePage extends StatefulWidget {
  const OnePage({super.key});

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  final nomeEC = TextEditingController();
  final cpfEC = TextEditingController();
  final dataNasEC = TextEditingController();
  final telefoneEC = TextEditingController();
  String? selectedValue;
  List<String> dropdownItems = ["Masculino", "Feminino"];

  void getDados() {
    debugPrint("eita deu certo zé");
    var model = LoginModel(
      nome: nomeEC.text,
      cpf: cpfEC.text,
      dataNas: dataNasEC.text,
      telefone: telefoneEC.text,
    );
    Navigator.pushNamed(context, '/two', arguments: model);
  }

  @override
  void dispose() {
    super.dispose();
    nomeEC.dispose();
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
