import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/auth_services.dart';
import 'package:projeto/Shared/Blocs/APIs/globals.dart';
import 'package:projeto/Shared/Blocs/APIs/seeds.dart';
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

  String? token;
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

  Future<void> stepThreeCreateAccountPressed() async {
    var responses = await Future.wait<void>([
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
        //Navigator.pushNamed(context, '/threeInfos');
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
  }

  stepThreeApiPeso() async {
    int peso = int.parse(pesoEC.text);
    http.Response response = await AuthServices.registerThreePeso(
      peso,
    );
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (mounted) {
        //Navigator.pushNamed(context, '/threeInfos');
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
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

  @override
  void initState() {
    super.initState();
    getToken().then((value) {
      setState(() {
        token = value;
      });
    });

    FetchData.fetchConsumoAlc().then((data) {
      setState(() {
        dataConsumoAlc = data;
      });
    });

    FetchData.fetchObjetivos().then((data) {
      setState(() {
        dataObjetivos = data;
      });
    });

    FetchData.fetchNivelAtiFis().then((data) {
      setState(() {
        dataNivelAtiFis = data;
      });
    });
    FetchData.fetchFumante().then((data) {
      setState(() {
        dataFumante = data;
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
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
                              label: "Altura",
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.brancoBege,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                const CustomText(
                                  text: 'Medicamentos',
                                  color: Colors.pretoPag,
                                  fontSize: 15,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        onFieldSubmitted: (z) {
                                          if (medicamentosEC.text.isNotEmpty) {
                                            setState(() {
                                              medicamentos
                                                  .add(medicamentosEC.text);
                                              medicamentosEC.clear();
                                            });
                                          }
                                        },
                                        controller: medicamentosEC,
                                        label: 'Digite seu medicamento...',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GlobalCustomElevatedButton(
                                      height: 40,
                                      width: 60,
                                      borderRadius: 50,
                                      onPressed: () {
                                        if (medicamentosEC.text.isNotEmpty) {
                                          setState(() {
                                            medicamentos
                                                .add(medicamentosEC.text);
                                            medicamentosEC.clear();
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: medicamentos
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
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.brancoBege,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                const CustomText(
                                  text: 'Comorbidades',
                                  color: Colors.pretoPag,
                                  fontSize: 15,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        onFieldSubmitted: (z) {
                                          if (comorbidadesEC.text.isNotEmpty) {
                                            setState(() {
                                              comorbidades
                                                  .add(comorbidadesEC.text);
                                              comorbidadesEC.clear();
                                            });
                                          }
                                        },
                                        controller: comorbidadesEC,
                                        label: 'Digite suas comorbidades',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GlobalCustomElevatedButton(
                                      height: 40,
                                      width: 60,
                                      borderRadius: 50,
                                      onPressed: () {
                                        if (comorbidadesEC.text.isNotEmpty) {
                                          setState(() {
                                            comorbidades
                                                .add(comorbidadesEC.text);
                                            comorbidadesEC.clear();
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: comorbidades
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      GlobalCustomElevatedButton(
                          width: double.infinity,
                          borderRadius: 50,
                          onPressed: () {
                            stepThreeCreateAccountPressed();
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
