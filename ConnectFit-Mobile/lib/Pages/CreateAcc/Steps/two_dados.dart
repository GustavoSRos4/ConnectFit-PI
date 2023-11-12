import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:projeto/Shared/Blocs/APIs/auth_services.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Widgets/custom_drop_down_button_form_field_sexo.dart';
import 'package:projeto/Shared/Widgets/custom_dropdown_search.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';

import 'package:http/http.dart' as http;
import '../../../Shared/Blocs/APIs/globals.dart';

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
  final bairroEC = TextEditingController();
  final complementoEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? selectedValue;
  String? token;
  List<Map<String, String>> estados = [];
  List<Map<String, String>> sexos = [];
  List<Map<String, dynamic>> cidades = [];
  String? estadoSelecionado;
  Map<String, dynamic>? cidadeSelecionada;
  int? idCidade;
  String siglaSexo = '';
  DateTime selectedDate = DateTime.now();

  stepTwoCreateAccountPressed() async {
    String telefoneString =
        telefoneEC.text.replaceAll(RegExp(r'[^\d]'), ''); // tirar as
    String dddString =
        telefoneString.substring(0, 2); // pego os 2 primeiros para DDD
    String numeroTelefoneString =
        telefoneString.substring(2); // e o restante para o numero
    int ddd = int.parse(dddString);
    int numeroTelefone = int.parse(numeroTelefoneString);
    String cpfString = cpfEC.text.replaceAll(RegExp(r'[^\d]'), '');
    int cpf = int.parse(cpfString);
    String cepString = cepEC.text.replaceAll(RegExp(r'[^\d]'), '');
    int cep = int.parse(cepString);

    try {
      http.Response response = await AuthServices.registerTwo(
        cpf,
        dataNasEC.text,
        ddd,
        numeroTelefone,
        logradouroEC.text,
        numeroEC.text,
        complementoEC.text,
        cep,
        bairroEC.text,
        idCidade!,
        siglaSexo,
      );

      if (response.statusCode == 201) {
        if (mounted) {
          Navigator.pushNamed(context, '/threeInfos');
        }
      } else {
        Map responseMap = jsonDecode(response.body);
        if (mounted) {
          errorSnackBar(context, responseMap.values.toString());
        }
      }
    } catch (e) {
      debugPrint('Ocorreu um erro: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    dataNasEC.dispose();
    cpfEC.dispose();
    telefoneEC.dispose();
    logradouroEC.dispose();
    numeroEC.dispose();
    cepEC.dispose();
    bairroEC.dispose();
    complementoEC.dispose();
  }

  @override
  void initState() {
    super.initState();

    getToken().then((value) {
      setState(() {
        token = value;
      });
    });

    FetchData.fetchSexo().then((data) {
      debugPrint('Sexos: $data');
      setState(() {
        sexos = data;
      });
    });

    FetchData.fetchEstados().then((data) {
      debugPrint('Estados: $data');
      setState(() {
        estados = data;
      });
    });
  }

  Future<void> _selectedDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        //dataNasEC.text = picked.toString().split(' ')[0];
        dataNasEC.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void buscarCidades(uf) {
    FetchData.fetchCidades(uf).then((data) {
      debugPrint('Estados: $data');
      setState(() {
        cidades = data;
      });
    });
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
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomDropdownSearch(
                        items: estados,
                        onChanged: (Map<String, dynamic>? novoEstado) {
                          buscarCidades(novoEstado?['SiglaUF']);
                          setState(() {
                            estadoSelecionado = novoEstado?['SiglaUF'];
                            cidadeSelecionada = null; // Adicione esta linha
                          });
                        },
                        labelPrincipal: 'Estado',
                        hintTextPrincipal: 'Escolha o estado...',
                        prefixIcon: const Icon(Icons.flag),
                        labelSecundaria: 'Buscar estado',
                        hintTextSecundaria: 'Digite o nome do estado...',
                        itemAsString: (Map<String, dynamic> estado) =>
                            estado['Descricao']!,
                      ),
                      const SizedBox(height: 15),

                      CustomDropdownSearch(
                        selectedItem: cidadeSelecionada,
                        items: cidades,
                        onChanged: (Map<String, dynamic>? novaCidade) {
                          setState(() {
                            cidadeSelecionada = novaCidade;
                            idCidade = novaCidade?['idCidade'];
                          });
                        },
                        labelPrincipal: 'Cidade',
                        hintTextPrincipal: 'Escolha a cidade...',
                        prefixIcon: const Icon(Icons.location_city),
                        labelSecundaria: 'Buscar cidade',
                        hintTextSecundaria: 'Digite o nome da cidade...',
                        itemAsString: (Map<String, dynamic> cidade) =>
                            cidade['NomeCidade']!,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        keyboardType: TextInputType.number,
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
                              icon: Icons.calendar_month,
                              controller: dataNasEC,
                              label: 'Nascimento',
                              readOnly: true,
                              onTap: () {
                                _selectedDate();
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: buildCustomDropdownButtonFormFieldSexo(
                              data: sexos,
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  siglaSexo = newValue;
                                });
                              },
                              labelText: 'Genêro',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        keyboardType: TextInputType.number,
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
                          if (!GetUtils.isPhoneNumber(text) ||
                              text.length < 14) {
                            return "Telefone Inválido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        maxLength: 150,
                        label: "Logradouro",
                        icon: Icons.location_on,
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
                              keyboardType: TextInputType.number,
                              label: "CEP",
                              icon: Icons.mail,
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
                                if (!GetUtils.isPhoneNumber(text) ||
                                    text.length < 10) {
                                  return "CEP Inválido";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomTextField(
                              label: "Numero",
                              icon: Icons.format_list_numbered,
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
                        maxLength: 50,
                        label: "Bairro",
                        icon: Icons.location_on,
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
                        maxLength: 15,
                        label: "Complemento",
                        icon: Icons.location_on,
                        hint: "Digite o complemento...",
                        controller: complementoEC,
                      ),
                      const SizedBox(height: 15),
                      GlobalCustomElevatedButton(
                        borderRadius: 50,
                        width: double.infinity,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            stepTwoCreateAccountPressed();
                          } else {
                            errorSnackBar(context,
                                'Por favor, preencha os campos corretamente!');
                          }
                        },
                        child: const CustomText(
                          text: "Avancar",
                          fontSize: 17,
                          isBold: true,
                        ),
                      ),
                      const SizedBox(height: 15),
                      //Testando
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
