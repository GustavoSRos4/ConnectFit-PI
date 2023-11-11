import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:projeto/Shared/Blocs/APIs/auth_services.dart';
import 'package:projeto/Shared/Blocs/APIs/seeds.dart';
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
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (mounted) {
        Navigator.pushNamed(context, '/threeInfos');
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
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
        dataNasEC.text = DateFormat('dd-MM-yyyy').format(picked);
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
                      DropdownSearch<Map<String, String>>(
                        popupProps: const PopupProps.menu(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              label: Text("Estado"),
                              hintText: "Digite o nome do estado...",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        ),
                        items: estados,
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            labelText: "Estado",
                            hintText: "Escolha o estado",
                          ),
                        ),
                        onChanged: (Map<String, String>? novoEstado) {
                          buscarCidades(novoEstado?['SiglaUF']);
                          setState(() {
                            estadoSelecionado = novoEstado?['SiglaUF'];
                            cidadeSelecionada = null; // Adicione esta linha
                          });
                        },
                        itemAsString: (Map<String, String> estado) =>
                            estado['Descricao']!,
                      ),
                      const SizedBox(height: 15),
                      DropdownSearch<Map<String, dynamic>>(
                        selectedItem: cidadeSelecionada,
                        popupProps: const PopupProps.menu(
                          menuProps: MenuProps(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          showSearchBox: true,
                          //showSelectedItems: true,
                          searchFieldProps: TextFieldProps(
                            padding: EdgeInsets.all(15.0),
                            decoration: InputDecoration(
                              label: Text("Cidade"),
                              hintText: "Digite o nome da cidade...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        ),
                        items: cidades,
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            fillColor: Colors.brancoBege,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            labelText: "Cidade",
                            hintText: "Escolha a cidade",
                          ),
                        ),
                        onChanged: (Map<String, dynamic>? novaCidade) {
                          setState(() {
                            cidadeSelecionada = novaCidade;
                            idCidade = novaCidade?['idCidade'];
                          });
                        },
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
                            child: DropdownButtonFormField<String>(
                              borderRadius: BorderRadius.circular(15),
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  siglaSexo = newValue;
                                });
                              },
                              items:
                                  sexos.map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem<String>(
                                  value: item['Sigla'],
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        item['Descricao'] == 'Feminino'
                                            ? Icons.female
                                            : Icons.male,
                                      ),
                                      Text(item['Descricao'] ?? ''),
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
                            Navigator.pushNamed(context, '/threeInfos');
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
