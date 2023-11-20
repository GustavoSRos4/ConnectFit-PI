import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_medidas.dart';

import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Blocs/APIs/Post/create_medida.dart';
import 'package:projeto/Shared/Blocs/globals.dart';
import 'package:projeto/Shared/Widgets/custom_container_title_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_list_tile_alterar_medidas.dart';
import 'package:http/http.dart' as http;

class PageMedidas extends StatefulWidget {
  const PageMedidas({super.key});

  @override
  State<PageMedidas> createState() => _PageMedidasState();
}

class _PageMedidasState extends State<PageMedidas> {
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

  salvarPressed() async {
    http.Response response = await ApiMedidas.registrarMedidas(
      areas,
    );
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 201) {
      setState(() {
        areas = [];
      });
      if (mounted) {
        loadData();
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

  String getDataAltercaoMedidaById(id) {
    String dataFormatada = '-';
    for (Map<String, dynamic> medida in medidas.reversed) {
      if (medida['idArea'] == id) {
        final createdAt = medida['created_at'];
        final createdAtMicro = DateTime.parse(createdAt).microsecondsSinceEpoch;
        DateTime data = DateTime.fromMicrosecondsSinceEpoch(createdAtMicro);
        dataFormatada = "${data.day}/${data.month}/${data.year}";
      }
    }
    return dataFormatada;
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
    salvarPressed();
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
    setState(() {
      isLoading = true;
    });
    await FetchData.fetchAreas().then((data) {
      setState(() {
        seedAreas = data;
      });
    });

    await FetchMedidas.fetchMedidas().then((data) {
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
        appBar: const CustomAppBar(
          title: Text("Medidas"),
          actions: [],
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
                      valorMedida: getValorMedidaById(1),
                      dataAlteracao: getDataAltercaoMedidaById(1),
                      textUnidadeMedida: '%',
                      controller: percentualGorduraEC,
                      funcao: () =>
                          joinMedidasInList(percentualGorduraEC.text, '1'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(2),
                      valorMedida: getValorMedidaById(2),
                      dataAlteracao: getDataAltercaoMedidaById(2),
                      textUnidadeMedida: 'Kg',
                      controller: pesoEC,
                      funcao: () => joinMedidasInList(pesoEC.text, '2'),
                    ),
                    const SizedBox(height: 20),
                    const CustomContainerTitlePerfil(text: 'Dobras'),
                    const SizedBox(height: 20),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(17),
                      valorMedida: getValorMedidaById(17),
                      dataAlteracao: getDataAltercaoMedidaById(17),
                      textUnidadeMedida: 'mm',
                      controller: axilarMediaEC,
                      funcao: () => joinMedidasInList(axilarMediaEC.text, '17'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(20),
                      valorMedida: getValorMedidaById(20),
                      dataAlteracao: getDataAltercaoMedidaById(20),
                      textUnidadeMedida: 'mm',
                      controller: femuralMediaEC,
                      funcao: () =>
                          joinMedidasInList(femuralMediaEC.text, '20'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(14),
                      valorMedida: getValorMedidaById(14),
                      dataAlteracao: getDataAltercaoMedidaById(14),
                      textUnidadeMedida: 'mm',
                      controller: subescapularEC,
                      funcao: () =>
                          joinMedidasInList(subescapularEC.text, '14'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(18),
                      valorMedida: getValorMedidaById(18),
                      dataAlteracao: getDataAltercaoMedidaById(18),
                      textUnidadeMedida: 'mm',
                      controller: supraIliacaEC,
                      funcao: () => joinMedidasInList(supraIliacaEC.text, '18'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(15),
                      valorMedida: getValorMedidaById(15),
                      dataAlteracao: getDataAltercaoMedidaById(15),
                      textUnidadeMedida: 'mm',
                      controller: tricepsEC,
                      funcao: () => joinMedidasInList(tricepsEC.text, '15'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(16),
                      valorMedida: getValorMedidaById(16),
                      dataAlteracao: getDataAltercaoMedidaById(16),
                      textUnidadeMedida: 'mm',
                      controller: peitoralEC,
                      funcao: () => joinMedidasInList(peitoralEC.text, '16'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(19),
                      valorMedida: getValorMedidaById(19),
                      dataAlteracao: getDataAltercaoMedidaById(19),
                      textUnidadeMedida: 'mm',
                      controller: abdominalEC,
                      funcao: () => joinMedidasInList(abdominalEC.text, '19'),
                    ),
                    const SizedBox(height: 20),
                    const CustomContainerTitlePerfil(text: 'Medidas Fita'),
                    const SizedBox(height: 20),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(3),
                      valorMedida: getValorMedidaById(3),
                      dataAlteracao: getDataAltercaoMedidaById(3),
                      textUnidadeMedida: 'cm',
                      controller: ombrosEC,
                      funcao: () => joinMedidasInList(ombrosEC.text, '3'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(4),
                      valorMedida: getValorMedidaById(4),
                      dataAlteracao: getDataAltercaoMedidaById(4),
                      textUnidadeMedida: 'cm',
                      controller: toraxEC,
                      funcao: () => joinMedidasInList(toraxEC.text, '4'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(5),
                      valorMedida: getValorMedidaById(5),
                      dataAlteracao: getDataAltercaoMedidaById(5),
                      textUnidadeMedida: 'cm',
                      controller: abdomenEC,
                      funcao: () => joinMedidasInList(abdomenEC.text, '5'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(6),
                      valorMedida: getValorMedidaById(6),
                      dataAlteracao: getDataAltercaoMedidaById(6),
                      textUnidadeMedida: 'cm',
                      controller: cinturaEC,
                      funcao: () => joinMedidasInList(cinturaEC.text, '6'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(7),
                      valorMedida: getValorMedidaById(7),
                      dataAlteracao: getDataAltercaoMedidaById(7),
                      textUnidadeMedida: 'cm',
                      controller: quadrilEC,
                      funcao: () => joinMedidasInList(quadrilEC.text, '7'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(8),
                      valorMedida: getValorMedidaById(8),
                      dataAlteracao: getDataAltercaoMedidaById(8),
                      textUnidadeMedida: 'cm',
                      controller: bracoEsqEC,
                      funcao: () => joinMedidasInList(bracoEsqEC.text, '8'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(9),
                      valorMedida: getValorMedidaById(9),
                      dataAlteracao: getDataAltercaoMedidaById(9),
                      textUnidadeMedida: 'cm',
                      controller: bracoDirEC,
                      funcao: () => joinMedidasInList(bracoDirEC.text, '9'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(10),
                      valorMedida: getValorMedidaById(10),
                      dataAlteracao: getDataAltercaoMedidaById(10),
                      textUnidadeMedida: 'cm',
                      controller: coxaEsqEC,
                      funcao: () => joinMedidasInList(coxaEsqEC.text, '10'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(11),
                      valorMedida: getValorMedidaById(11),
                      dataAlteracao: getDataAltercaoMedidaById(11),
                      textUnidadeMedida: 'cm',
                      controller: coxaDirEC,
                      funcao: () => joinMedidasInList(coxaDirEC.text, '11'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(12),
                      valorMedida: getValorMedidaById(12),
                      dataAlteracao: getDataAltercaoMedidaById(12),
                      textUnidadeMedida: 'cm',
                      controller: pernaEsqEC,
                      funcao: () => joinMedidasInList(pernaEsqEC.text, '12'),
                    ),
                    const SizedBox(height: 10),
                    CustomListTileAlterarMedidas(
                      nomeMedida: getNameById(13),
                      valorMedida: getValorMedidaById(13),
                      dataAlteracao: getDataAltercaoMedidaById(13),
                      textUnidadeMedida: 'cm',
                      controller: pernaDirEC,
                      funcao: () {
                        joinMedidasInList(pernaDirEC.text, '13');
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ));
  }
}
