import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_medidas.dart';

import 'package:projeto/Shared/Blocs/APIs/create_medida.dart';
import 'package:projeto/Shared/Blocs/APIs/globals.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_container_title_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_list_tile_alterar_medidas.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';

class PageMedidasAlterar extends StatefulWidget {
  const PageMedidasAlterar({super.key});

  @override
  State<PageMedidasAlterar> createState() => _PageMedidasAlterarState();
}

class _PageMedidasAlterarState extends State<PageMedidasAlterar> {
  List<Map<String, dynamic>> seedAreas = [];
  final abdominalEC = TextEditingController();
  final axilarMediaEC = TextEditingController();
  final femuralMediaEC = TextEditingController();
  final peitoralEC = TextEditingController();
  final percentualGorduraEC = TextEditingController();
  final pesoEC = TextEditingController();
  final subescapularEC = TextEditingController();
  final supraIliacaEC = TextEditingController();
  final tricepsEC = TextEditingController();
  final ombrosEC = TextEditingController();
  final toraxEC = TextEditingController();
  final abdomenEC = TextEditingController();
  final cinturaEC = TextEditingController();
  final quadrilEC = TextEditingController();
  final bracoEsqEC = TextEditingController();
  final bracoDirEC = TextEditingController();
  final coxaEsqEC = TextEditingController();
  final coxaDirEC = TextEditingController();
  final pernaEsqEC = TextEditingController();
  final pernaDirEC = TextEditingController();
  List<Map<dynamic, dynamic>> areas = [];
  List<Map<String, dynamic>> medidas = [];
  bool isLoading = true;

  MedidasModel? model;

  salvarPressed() async {
    http.Response response = await ApiMedidas.registrarMedidas(
      areas,
    );

    Map responseMap = jsonDecode(response.body);
    debugPrint("Código de status da resposta: ${response.statusCode}");
    if (response.statusCode == 201) {
      setState(() {
        areas = [];
      });

      if (mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/measures');
        debugPrint("Deu certo 201");
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
  }

  getValorMedidaById(id) {
    var valor = 0;
    for (Map<String, dynamic> mapa in medidas.reversed) {
      if (mapa['idArea'] == id) {
        valor = mapa['medida'];
      }
    }
    return valor;
  }

  joinMedidasInList(String medida, String id) {
    int index = areas.indexWhere((element) => element["idArea"] == id);
    setState(() {
      if (index != -1) {
        areas[index]["medida"] = medida;
      } else {
        areas.add({
          "medida": medida,
          "idArea": id,
        });
      }
    });
    debugPrint(areas.toString());
  }

  String getNameById(int id) {
    for (Map<String, dynamic> area in seedAreas) {
      if (area['id'] == id) {
        return area['Descricao'];
      }
    }
    return '';
  }

  Future<void> loadData() async {
    FetchData.fetchAreas().then((data) {
      debugPrint('Areas: $data');
      setState(() {
        seedAreas = data;
      });
    });

    FetchMedidas.fetchMedidas().then((data) {
      debugPrint('Medidas: $data');
      setState(() {
        medidas = data;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: const Text("Atualizar Medidas"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const CustomContainerTitlePerfil(text: 'Corpo'),
                    const SizedBox(height: 20),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(1),
                      valorMedida: percentualGorduraEC.text.isNotEmpty
                          ? int.parse(percentualGorduraEC.text)
                          : getValorMedidaById(1),
                      dataAlteracao: "10/09/2023",
                      textUnidadeMedida: '%',
                      controller: percentualGorduraEC,
                      funcao: () =>
                          joinMedidasInList(percentualGorduraEC.text, '1'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(2),
                      valorMedida: pesoEC.text.isNotEmpty
                          ? int.parse(pesoEC.text)
                          : getValorMedidaById(2),
                      dataAlteracao: "10/10/2023",
                      textUnidadeMedida: 'Kg',
                      controller: pesoEC,
                      funcao: () => joinMedidasInList(pesoEC.text, '2'),
                    ),
                    const SizedBox(height: 20),
                    const CustomContainerTitlePerfil(text: 'Dobras'),
                    const SizedBox(height: 20),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(17),
                      valorMedida: axilarMediaEC.text.isNotEmpty
                          ? int.parse(axilarMediaEC.text)
                          : getValorMedidaById(17),
                      dataAlteracao: "10/11/2023",
                      textUnidadeMedida: 'mm',
                      controller: axilarMediaEC,
                      funcao: () => joinMedidasInList(axilarMediaEC.text, '17'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(20),
                      valorMedida: femuralMediaEC.text.isNotEmpty
                          ? int.parse(femuralMediaEC.text)
                          : getValorMedidaById(20),
                      dataAlteracao: "15/11/2023",
                      textUnidadeMedida: 'mm',
                      controller: femuralMediaEC,
                      funcao: () =>
                          joinMedidasInList(femuralMediaEC.text, '20'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(14),
                      valorMedida: subescapularEC.text.isNotEmpty
                          ? int.parse(subescapularEC.text)
                          : getValorMedidaById(14),
                      dataAlteracao: "10/11/2023",
                      textUnidadeMedida: 'mm',
                      controller: subescapularEC,
                      funcao: () =>
                          joinMedidasInList(subescapularEC.text, '14'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(18),
                      valorMedida: supraIliacaEC.text.isNotEmpty
                          ? int.parse(supraIliacaEC.text)
                          : getValorMedidaById(18),
                      dataAlteracao: "10/11/2023",
                      textUnidadeMedida: 'mm',
                      controller: supraIliacaEC,
                      funcao: () => joinMedidasInList(supraIliacaEC.text, '18'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(15),
                      valorMedida: tricepsEC.text.isNotEmpty
                          ? int.parse(tricepsEC.text)
                          : getValorMedidaById(15),
                      dataAlteracao: "10/11/2023",
                      textUnidadeMedida: 'mm',
                      controller: tricepsEC,
                      funcao: () => joinMedidasInList(tricepsEC.text, '15'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(16),
                      valorMedida: peitoralEC.text.isNotEmpty
                          ? int.parse(peitoralEC.text)
                          : getValorMedidaById(16),
                      dataAlteracao: "10/11/2023",
                      textUnidadeMedida: 'mm',
                      controller: peitoralEC,
                      funcao: () => joinMedidasInList(peitoralEC.text, '16'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(19),
                      valorMedida: abdominalEC.text.isNotEmpty
                          ? int.parse(abdominalEC.text)
                          : getValorMedidaById(19),
                      dataAlteracao: "10/11/2023",
                      textUnidadeMedida: 'mm',
                      controller: abdominalEC,
                      funcao: () => joinMedidasInList(abdominalEC.text, '19'),
                    ),
                    const SizedBox(height: 20),
                    const CustomContainerTitlePerfil(text: 'Medidas Fita'),
                    const SizedBox(height: 20),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(3),
                      valorMedida: ombrosEC.text.isNotEmpty
                          ? int.parse(ombrosEC.text)
                          : getValorMedidaById(3),
                      dataAlteracao: "09/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: ombrosEC,
                      funcao: () => joinMedidasInList(ombrosEC.text, '3'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(4),
                      valorMedida: toraxEC.text.isNotEmpty
                          ? int.parse(toraxEC.text)
                          : getValorMedidaById(4),
                      dataAlteracao: "10/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: toraxEC,
                      funcao: () => joinMedidasInList(toraxEC.text, '4'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(5),
                      valorMedida: abdomenEC.text.isNotEmpty
                          ? int.parse(abdomenEC.text)
                          : getValorMedidaById(5),
                      dataAlteracao: "11/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: abdomenEC,
                      funcao: () => joinMedidasInList(abdomenEC.text, '5'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(6),
                      valorMedida: cinturaEC.text.isNotEmpty
                          ? int.parse(cinturaEC.text)
                          : getValorMedidaById(6),
                      dataAlteracao: "12/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: cinturaEC,
                      funcao: () => joinMedidasInList(cinturaEC.text, '6'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(7),
                      valorMedida: quadrilEC.text.isNotEmpty
                          ? int.parse(quadrilEC.text)
                          : getValorMedidaById(7),
                      dataAlteracao: "13/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: quadrilEC,
                      funcao: () => joinMedidasInList(quadrilEC.text, '7'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(8),
                      valorMedida: bracoEsqEC.text.isNotEmpty
                          ? int.parse(bracoEsqEC.text)
                          : getValorMedidaById(8),
                      dataAlteracao: "14/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: bracoEsqEC,
                      funcao: () => joinMedidasInList(bracoEsqEC.text, '8'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(9),
                      valorMedida: bracoDirEC.text.isNotEmpty
                          ? int.parse(bracoDirEC.text)
                          : getValorMedidaById(9),
                      dataAlteracao: "15/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: bracoDirEC,
                      funcao: () => joinMedidasInList(bracoDirEC.text, '9'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(10),
                      valorMedida: coxaEsqEC.text.isNotEmpty
                          ? int.parse(coxaEsqEC.text)
                          : getValorMedidaById(10),
                      dataAlteracao: "16/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: coxaEsqEC,
                      funcao: () => joinMedidasInList(coxaEsqEC.text, '10'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(11),
                      valorMedida: coxaDirEC.text.isNotEmpty
                          ? int.parse(coxaDirEC.text)
                          : getValorMedidaById(11),
                      dataAlteracao: "16/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: coxaDirEC,
                      funcao: () => joinMedidasInList(coxaDirEC.text, '11'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(12),
                      valorMedida: pernaEsqEC.text.isNotEmpty
                          ? int.parse(pernaEsqEC.text)
                          : getValorMedidaById(12),
                      dataAlteracao: "17/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: pernaEsqEC,
                      funcao: () => joinMedidasInList(pernaEsqEC.text, '12'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(13),
                      valorMedida: pernaDirEC.text.isNotEmpty
                          ? int.parse(pernaDirEC.text)
                          : getValorMedidaById(13),
                      dataAlteracao: "17/11/2023",
                      textUnidadeMedida: 'cm',
                      controller: pernaDirEC,
                      funcao: () => joinMedidasInList(pernaDirEC.text, '13'),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GlobalCustomElevatedButton(
                            width: 150,
                            onPressed: () => {Navigator.pop(context)},
                            child: const CustomText(
                              text: 'Cancelar',
                              fontSize: 17,
                              isBold: true,
                            ),
                          ),
                          GlobalCustomElevatedButton(
                            width: 150,
                            onPressed: () => salvarPressed(),
                            child: const CustomText(
                              text: 'Salvar',
                              fontSize: 17,
                              isBold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ));
  }
}
