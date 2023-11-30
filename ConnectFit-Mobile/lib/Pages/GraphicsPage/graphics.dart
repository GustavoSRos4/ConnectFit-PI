import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_medidas.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_dropdown_button_form_field.dart';
import 'package:projeto/Shared/Widgets/Charts/line_chart.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class GraphicsPage extends StatefulWidget {
  const GraphicsPage({Key? key}) : super(key: key);

  @override
  State<GraphicsPage> createState() => _GraphicsPageState();
}

class _GraphicsPageState extends State<GraphicsPage> {
  List<Map<String, dynamic>> seedAreas = [];
  List<Map<String, dynamic>> medidas = [];
  int? idArea;
  bool isLoading = true;

  Future<void> loadData() async {
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

  void onChangedArea(int newValue) {
    setState(() {
      idArea = newValue;
    });
  }

  List<List<dynamic>> mapMedidasParaChartData(
      List<Map<String, dynamic>> medidas, int? selectedId) {
    return medidas.reversed
        .where((medida) => medida['idArea'] == selectedId)
        .map((medida) {
      final createdAt = medida['created_at'];
      final valor = medida['medida'].toDouble();
      final data = DateTime.parse(createdAt).microsecondsSinceEpoch;
      return [data, valor];
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> chartData = mapMedidasParaChartData(medidas, idArea);
    seedAreas.sort((a, b) => a['Descricao'].compareTo(b['Descricao']));
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Gráficos',
        ),
        actions: [],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
                top: 20,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        opacity: 0.1,
                        image: AssetImage(
                          "assets/images/iconeApp.png",
                        ),
                      ),
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            buildCustomDropdownButtonFormField(
                              fillCollor: Colors.transparent,
                              menuMaxHeight: 300,
                              data: seedAreas,
                              value: idArea,
                              onChanged: onChangedArea,
                              labelText: 'Medida',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            idArea == null
                                ? const Center(
                                    child: CustomText(
                                        text:
                                            'Selecione a medida a ser exibida..'),
                                  )
                                : chartData.length < 2
                                    ? const Center(
                                        child: CustomText(
                                            text:
                                                'Não há dados suficientes para exibir o gráfico.'),
                                      )
                                    : MyLineChart(
                                        dados: chartData,
                                      )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: mapMedidasParaChartData(medidas, idArea)
                            .reversed
                            .map((item) {
                          debugPrint(item.toString());

                          DateTime data =
                              DateTime.fromMicrosecondsSinceEpoch(item[0]);
                          String dataFormatada =
                              "${data.day}/${data.month}/${data.year}";
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5, top: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomRowText(
                                  indicador: 'Data',
                                  valor: dataFormatada,
                                ),
                                CustomRowText(
                                  indicador: 'Medição',
                                  valor: '${item[1]}',
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
