import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_medidas.dart';

import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_container_title_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_list_tile_medidas.dart';

import 'package:projeto/Shared/Widgets/custom_text.dart';

class PageMedidas extends StatefulWidget {
  const PageMedidas({super.key});

  @override
  State<PageMedidas> createState() => _PageMedidasState();
}

class _PageMedidasState extends State<PageMedidas> {
  List<Map<String, dynamic>> seedAreas = [];
  List<Map<String, dynamic>> medidas = [];
  List<Map<String, String>> areass = [];
  MedidasModel? model;
  bool isLoading = true;

  String getNameById(int id) {
    for (Map<String, dynamic> area in seedAreas) {
      if (area['id'] == id) {
        return area['Descricao'];
      }
    }
    return '';
  }

  Future<void> loadData() async {
    await FetchData.fetchAreas().then((data) {
      setState(() {
        seedAreas = data;
      });
    });

    await FetchMedidas.fetchMedidas().then((data) {
      debugPrint(data.toString());
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
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, '/alterarMedidas');
                          await FetchMedidas.fetchMedidas().then((data) {
                            debugPrint('Medidas: $data');
                            setState(() {
                              medidas = data;
                            });
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: "Atualizar Medidas",
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.create,
                                color: Colors.brancoBege,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const CustomContainerTitlePerfil(text: 'Corpo'),
                    const SizedBox(height: 20),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(1),
                      valorMedida: getValorMedidaById(1),
                      dataAlteracao: getDataAltercaoMedidaById(1),
                      textUnidadeMedida: '%',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(2),
                      valorMedida: getValorMedidaById(2),
                      dataAlteracao: getDataAltercaoMedidaById(2),
                      textUnidadeMedida: 'Kg',
                    ),
                    const SizedBox(height: 20),
                    const CustomContainerTitlePerfil(text: 'Dobras'),
                    const SizedBox(height: 20),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(17),
                      valorMedida: getValorMedidaById(17),
                      dataAlteracao: getDataAltercaoMedidaById(17),
                      textUnidadeMedida: 'mm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(20),
                      valorMedida: getValorMedidaById(20),
                      dataAlteracao: getDataAltercaoMedidaById(20),
                      textUnidadeMedida: 'mm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(14),
                      valorMedida: getValorMedidaById(14),
                      dataAlteracao: getDataAltercaoMedidaById(14),
                      textUnidadeMedida: 'mm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(18),
                      valorMedida: getValorMedidaById(18),
                      dataAlteracao: getDataAltercaoMedidaById(18),
                      textUnidadeMedida: 'mm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(15),
                      valorMedida: getValorMedidaById(15),
                      dataAlteracao: getDataAltercaoMedidaById(15),
                      textUnidadeMedida: 'mm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(16),
                      valorMedida: getValorMedidaById(16),
                      dataAlteracao: getDataAltercaoMedidaById(16),
                      textUnidadeMedida: 'mm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(19),
                      valorMedida: getValorMedidaById(19),
                      dataAlteracao: getDataAltercaoMedidaById(19),
                      textUnidadeMedida: 'mm',
                    ),
                    const SizedBox(height: 20),
                    const CustomContainerTitlePerfil(text: 'Medidas Fita'),
                    const SizedBox(height: 20),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(3),
                      valorMedida: getValorMedidaById(3),
                      dataAlteracao: getDataAltercaoMedidaById(3),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(4),
                      valorMedida: getValorMedidaById(4),
                      dataAlteracao: getDataAltercaoMedidaById(4),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(5),
                      valorMedida: getValorMedidaById(5),
                      dataAlteracao: getDataAltercaoMedidaById(5),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(6),
                      valorMedida: getValorMedidaById(6),
                      dataAlteracao: getDataAltercaoMedidaById(6),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(7),
                      valorMedida: getValorMedidaById(7),
                      dataAlteracao: getDataAltercaoMedidaById(7),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(8),
                      valorMedida: getValorMedidaById(8),
                      dataAlteracao: getDataAltercaoMedidaById(8),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(9),
                      valorMedida: getValorMedidaById(9),
                      dataAlteracao: getDataAltercaoMedidaById(9),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(10),
                      valorMedida: getValorMedidaById(10),
                      dataAlteracao: getDataAltercaoMedidaById(10),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(11),
                      valorMedida: getValorMedidaById(11),
                      dataAlteracao: getDataAltercaoMedidaById(11),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(12),
                      valorMedida: getValorMedidaById(12),
                      dataAlteracao: getDataAltercaoMedidaById(12),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                    CustomListTileMedidas(
                      nomeMedida: getNameById(13),
                      valorMedida: getValorMedidaById(13),
                      dataAlteracao: getDataAltercaoMedidaById(13),
                      textUnidadeMedida: 'cm',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ));
  }
}

class getValorMedidaByIdExpansion extends StatelessWidget {
  final String text;
  final List<Widget> children;
  const getValorMedidaByIdExpansion({
    super.key,
    required this.text,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {},
      collapsedBackgroundColor: Colors.deepOrange,
      iconColor: Colors.white,
      title: CustomText(
        text: text,
        isBold: true,
        fontSize: 15,
      ),
      children: children,
    );
  }
}
