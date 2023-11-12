import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/Shared/Blocs/APIs/auth_services.dart';
import 'package:projeto/Shared/Blocs/APIs/create_medida.dart';
import 'package:projeto/Shared/Blocs/APIs/globals.dart';
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
  final List<String> medicamentos = [];
  final List<String> comorbidades = [];
  final formKey = GlobalKey<FormState>();

  String? token;
  bool isLoading = true;
  final alturaEC = TextEditingController();
  final pesoEC = TextEditingController();
  List<Map<String, dynamic>> dataConsumoAlc = [];
  int idConsumoAlc = 1;
  List<Map<String, dynamic>> dataObjetivos = [];
  int idObjetivo = 1;
  List<Map<String, dynamic>> dataFumante = [];
  int idFumante = 1;
  List<Map<String, dynamic>> dataNivelAtiFis = [];
  int idNivelAtiFis = 1;
  List<Map<dynamic, dynamic>> peso = [];

  Future<void> stepThreeCreateAccountPressed() async {
    await Future.wait<void>([
      joinMedidasInList(pesoEC.text, '2'),
      stepThreeApiPeso(),
      stepThreeCreateApiAnamnese(),
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
    if (response.statusCode == 200) {
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
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
    debugPrint("Código de status da resposta: ${response.statusCode}");
    if (response.statusCode == 201) {
      setState(() {
        peso = [];
      });
      if (mounted) {
        debugPrint("Deu certo 201");
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
    debugPrint(peso.toString());
  }

  void enviarMedicamentos() {
    for (String medicamento in medicamentos) {
      medicamentosMap.add({"descricao": medicamento});
    }
  }

  void enviarComorbidades() {
    for (String comorbidades in comorbidades) {
      comorbidadesMap.add({"descricao": comorbidades});
    }
  }

  void onChangedObjetivo(int newValue) {
    debugPrint("$newValue");
    setState(() {
      idObjetivo = newValue;
    });
  }

  void onChangedConsumoAlc(int newValue) {
    debugPrint("$newValue");
    setState(() {
      idConsumoAlc = newValue;
    });
  }

  void onChangedNivelAtiFis(int newValue) {
    debugPrint("$newValue");
    setState(() {
      idNivelAtiFis = newValue;
    });
  }

  void onChangedFumante(int newValue) {
    debugPrint("$newValue");
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
    getToken().then((value) {
      setState(() {
        token = value;
      });
    });

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
                                        return "Esse campo não pode ficar vazio";
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
                                        return "Esse campo não pode ficar vazio";
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
                                    if (medicamentosEC.text.isNotEmpty) {
                                      setState(() {
                                        medicamentos.add(medicamentosEC.text);
                                        medicamentosEC.clear();
                                      });
                                    }
                                  },
                                  onPressedButton: () {
                                    if (medicamentosEC.text.isNotEmpty) {
                                      setState(() {
                                        medicamentos.add(medicamentosEC.text);
                                        medicamentosEC.clear();
                                      });
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
                                    if (comorbidadesEC.text.isNotEmpty) {
                                      setState(() {
                                        comorbidades.add(comorbidadesEC.text);
                                        comorbidadesEC.clear();
                                      });
                                    }
                                  },
                                  controller: comorbidadesEC,
                                  label: 'Digite suas comorbidades',
                                  onPressedButton: () {
                                    if (comorbidadesEC.text.isNotEmpty) {
                                      setState(() {
                                        comorbidades.add(comorbidadesEC.text);
                                        comorbidadesEC.clear();
                                      });
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
                                ))
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
