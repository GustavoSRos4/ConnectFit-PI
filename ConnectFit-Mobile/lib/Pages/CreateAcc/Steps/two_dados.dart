import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:projeto/Shared/Blocs/auth_services.dart';
import 'package:projeto/Shared/Blocs/seeds.dart';
import 'package:projeto/Shared/Models/login_model.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/positioned_float_action_button.dart';
import 'package:http/http.dart' as http;
import '../../../Shared/Blocs/globals.dart';

class TwoDados extends StatefulWidget {
  const TwoDados({super.key});

  @override
  State<TwoDados> createState() => _OnePageState();
}

class _OnePageState extends State<TwoDados> {
  final cpfEC = TextEditingController();
  final dataNasEC = TextEditingController();
  final dddEC = TextEditingController();
  final telefoneEC = TextEditingController();
  final cepEC = TextEditingController();
  final logradouroEC = TextEditingController();
  final numeroEC = TextEditingController();
  final cidadeEC = TextEditingController();
  final bairroEC = TextEditingController();
  final estadoEC = TextEditingController();
  String? selectedValue;
  List<String> dropdownItems = ["Masculino", "Feminino"];
  String? token;
  List<String> estados = [];
  List<Map<String, String>> sexos = [];
  String? estadoSelecionado;
  Map<String, dynamic>? cidadeSelecionada;
  int idCidade = 0;
  String siglaSexo = '';

  stepTwoCreateAccountPressed() async {
    debugPrint("STEP 2 CREATE");
    if (bairroEC.text != '') {
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
        cidadeEC.text,
        cep,
        bairroEC.text,
        idCidade,
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
    } else {
      if (mounted) {
        errorSnackBar(context, 'email not valid');
      }
    }
  }

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
    dddEC.dispose();
    telefoneEC.dispose();
    logradouroEC.dispose();
    numeroEC.dispose();
    cidadeEC.dispose();
    cepEC.dispose();
    bairroEC.dispose();
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
      debugPrint('Dados: $data');
      setState(() {
        sexos = data;
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: estados.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(estados[index]),
                          );
                        },
                      ),
                      FutureBuilder<Map<String, String>>(
                        future: FetchData.fetchEstados(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<String, String>> snapshot) {
                          if (snapshot.hasData) {
                            return DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                showSelectedItems: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Buscar",
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
                              items: snapshot.data?.keys.toList() ?? [],
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
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
                              onChanged: (String? novoEstado) {
                                setState(() {
                                  estadoSelecionado =
                                      snapshot.data?[novoEstado];
                                  cidadeSelecionada =
                                      null; // Adicione esta linha
                                });
                              },
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Erro ao carregar os dados.');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: FetchData.fetchCidades(estadoSelecionado),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            return DropdownSearch<Map<String, dynamic>>(
                              compareFn: (Map<String, dynamic> item1,
                                  Map<String, dynamic> item2) {
                                return item1['idCidade'] == item2['idCidade'];
                              },
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                showSelectedItems: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Buscar",
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
                              items: snapshot.data ?? [],
                              itemAsString: (item) => item[
                                  'NomeCidade'], // use o nome da cidade para exibir
                              selectedItem:
                                  cidadeSelecionada, // Adicione esta linha
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
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
                                  cidadeSelecionada = novaCidade?['NomeCidade'];
                                  idCidade = novaCidade?[
                                      'idCidade']; // obtenha o idCidade aqui
                                });
                              },
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Erro ao carregar os dados.');
                          } else {
                            return const CircularProgressIndicator();
                          }
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
          PositionedActionButton(
              onPressed: () => stepTwoCreateAccountPressed()),
        ],
      ),
    );
  }
}
