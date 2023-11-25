import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/Pages/HomePage/home.dart';
import 'package:projeto/Shared/Blocs/APIs/Post/auth_services.dart';
import 'package:projeto/Shared/Blocs/APIs/Post/create_medida.dart';
import 'package:projeto/Shared/Blocs/globals.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Widgets/custom_container_text_field_add_various_itens.dart';
import 'package:projeto/Shared/Widgets/custom_dropdown_button_form_field.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';

import 'package:http/http.dart' as http;

class ThreeInfos extends StatefulWidget {
  const ThreeInfos({super.key});

  @override
  State<ThreeInfos> createState() => _ThreeInfosState();
}

class _ThreeInfosState extends State<ThreeInfos> {
  final medicamentosEC = TextEditingController();
  final comorbidadesEC = TextEditingController();
  List<Map<String, String>> medicamentosMap = [];
  List<Map<String, String>> comorbidadesMap = [];
  List<String> medicamentos = [];
  List<String> comorbidades = [];
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;
  final alturaEC = TextEditingController();
  final pesoEC = TextEditingController();
  List<Map<String, dynamic>> dataConsumoAlc = [];
  int? idConsumoAlc;
  List<Map<String, dynamic>> dataObjetivos = [];
  int? idObjetivo;
  List<Map<String, dynamic>> dataFumante = [];
  int? idFumante;
  List<Map<String, dynamic>> dataNivelAtiFis = [];
  int? idNivelAtiFis;
  List<Map<dynamic, dynamic>> peso = [];

  Future<void> stepThreeCreateAccountPressed() async {
    await Future.wait<void>([
      joinMedidasInList(pesoEC.text, '2'),
      stepThreeCreateApiAnamnese(),
      stepThreeApiPeso(),
    ]);
  }

  stepThreeCreateApiAnamnese() async {
    int altura = int.parse(alturaEC.text);
    enviarMedicamentos();
    enviarComorbidades();
    http.Response response = await AuthServices.registerThree(
      altura,
      idFumante,
      idNivelAtiFis,
      idObjetivo,
      idConsumoAlc,
      medicamentosMap,
      comorbidadesMap,
    );

    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 201) {
      if (mounted) {
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
  }

  stepThreeApiPeso() async {
    http.Response response = await ApiMedidas.registrarMedidas(
      peso,
    );

    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        peso = [];
      });

      if (mounted) {
        Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const Home(),
          ),
        );
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
  }

  joinMedidasInList(String medida, String id) async {
    int index = peso.indexWhere((element) => element["idArea"] == id);
    setState(() {
      if (index != -1) {
        peso[index]["medida"] = medida;
      } else {
        peso.add({
          "medida": medida,
          "idArea": id,
        });
      }
    });
  }

  void enviarMedicamentos() {
    for (String medicamento in medicamentos) {
      if (!medicamentosMap.any((map) => map['descricao'] == medicamento)) {
        medicamentosMap.add({"descricao": medicamento});
      } else {
        errorSnackBar(context,
            "Erro ao cadastrar, medicamento já existe para esse usuário");
      }
    }
  }

  void enviarComorbidades() {
    for (String comorbidade in comorbidades) {
      if (!comorbidadesMap.any((map) => map['descricao'] == comorbidade)) {
        comorbidadesMap.add({"descricao": comorbidade});
      } else {
        errorSnackBar(context,
            "Erro ao cadastrar, comorbidade já existe para esse usuário");
      }
    }
  }

  void onChangedObjetivo(int newValue) {
    setState(() {
      idObjetivo = newValue;
    });
  }

  void onChangedConsumoAlc(int newValue) {
    setState(() {
      idConsumoAlc = newValue;
    });
  }

  void onChangedNivelAtiFis(int newValue) {
    setState(() {
      idNivelAtiFis = newValue;
    });
  }

  void onChangedFumante(int newValue) {
    setState(() {
      idFumante = newValue;
    });
  }

  Future<void> loaddata() async {
    await FetchData.fetchConsumoAlc().then((data) {
      setState(() {
        dataConsumoAlc = data;
      });
    });

    await FetchData.fetchObjetivos().then((data) {
      setState(() {
        dataObjetivos = data;
      });
    });

    await FetchData.fetchNivelAtiFis().then((data) {
      setState(() {
        dataNivelAtiFis = data;
      });
    });
    await FetchData.fetchFumante().then((data) {
      setState(() {
        dataFumante = data;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    label: "Peso",
                                    icon: Icons.person,
                                    hint: "Insira...",
                                    controller: pesoEC,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Digite seu peso.";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: CustomTextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    label: "Altura (cm)",
                                    icon: Icons.person,
                                    hint: "Insira...",
                                    controller: alturaEC,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Digite sua altura.";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: buildCustomDropdownButtonFormField(
                                      data: dataConsumoAlc,
                                      value: idConsumoAlc,
                                      onChanged: onChangedConsumoAlc,
                                      labelText: 'Consumo Alcoólico'),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: buildCustomDropdownButtonFormField(
                                      data: dataFumante,
                                      value: idFumante,
                                      onChanged: onChangedFumante,
                                      labelText: 'Você fuma?'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            buildCustomDropdownButtonFormField(
                                data: dataObjetivos,
                                value: idObjetivo,
                                onChanged: onChangedObjetivo,
                                labelText: 'Objetivo'),
                            const SizedBox(height: 15),
                            buildCustomDropdownButtonFormField(
                                data: dataNivelAtiFis,
                                value: idNivelAtiFis,
                                onChanged: onChangedNivelAtiFis,
                                labelText: 'Nível de Atividade Fisica'),
                            const SizedBox(height: 15),
                            Column(
                              children: <Widget>[
                                customContainerTextFieldAddVariousItens(
                                  label: 'Digite seu medicamento...',
                                  controller: medicamentosEC,
                                  textTitulo: 'Medicamentos',
                                  onFieldSubmitted: (z) {
                                    final String newMedicamento =
                                        medicamentosEC.text;

                                    if (newMedicamento.isNotEmpty &&
                                        !medicamentos
                                            .contains(newMedicamento)) {
                                      setState(() {
                                        medicamentos.add(newMedicamento);
                                        medicamentosEC.clear();
                                      });
                                    } else {
                                      if (newMedicamento.isEmpty) {
                                      } else {
                                        errorSnackBar(context,
                                            'Você já adicionou: $newMedicamento ');
                                      }
                                    }
                                  },
                                  onPressedButton: () {
                                    final String newMedicamento =
                                        medicamentosEC.text;

                                    if (newMedicamento.isNotEmpty &&
                                        !medicamentos
                                            .contains(newMedicamento)) {
                                      setState(() {
                                        medicamentos.add(newMedicamento);
                                        medicamentosEC.clear();
                                      });
                                    } else {
                                      if (newMedicamento.isEmpty) {
                                      } else {
                                        errorSnackBar(context,
                                            'Você já adicionou: $newMedicamento ');
                                      }
                                    }
                                  },
                                  childrenChip: medicamentos
                                      .map((medicamento) => Chip(
                                            label: Text(medicamento),
                                            onDeleted: () {
                                              setState(() {
                                                medicamentos
                                                    .remove(medicamento);
                                              });
                                            },
                                          ))
                                      .toList(),
                                ),
                                const SizedBox(height: 15),
                                customContainerTextFieldAddVariousItens(
                                  textTitulo: 'Comorbidades',
                                  onFieldSubmitted: (z) {
                                    final String newComorbidade =
                                        comorbidadesEC.text;

                                    if (newComorbidade.isNotEmpty &&
                                        !comorbidades
                                            .contains(newComorbidade)) {
                                      setState(() {
                                        comorbidades.add(newComorbidade);
                                        comorbidadesEC.clear();
                                      });
                                    } else {
                                      if (newComorbidade.isEmpty) {
                                      } else {
                                        errorSnackBar(context,
                                            'Você já adicionou: $newComorbidade ');
                                      }
                                    }
                                  },
                                  controller: comorbidadesEC,
                                  label: 'Digite suas comorbidades',
                                  onPressedButton: () {
                                    final String newComorbidade =
                                        comorbidadesEC.text;

                                    if (newComorbidade.isNotEmpty &&
                                        !comorbidades
                                            .contains(newComorbidade)) {
                                      setState(() {
                                        comorbidades.add(newComorbidade);
                                        comorbidadesEC.clear();
                                      });
                                    } else {
                                      if (newComorbidade.isEmpty) {
                                      } else {
                                        errorSnackBar(context,
                                            'Você já adicionou: $newComorbidade ');
                                      }
                                    }
                                  },
                                  childrenChip: comorbidades
                                      .map((comorbidade) => Chip(
                                            label: Text(comorbidade),
                                            onDeleted: () {
                                              setState(() {
                                                comorbidades
                                                    .remove(comorbidade);
                                              });
                                            },
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            GlobalCustomElevatedButton(
                              width: double.infinity,
                              borderRadius: 50,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  stepThreeCreateAccountPressed();
                                } else {
                                  errorSnackBar(context,
                                      'Por favor, preencha os campos corretamente!');
                                }
                              },
                              child: const CustomText(
                                text: "Avançar",
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
