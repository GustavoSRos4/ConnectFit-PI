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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 4,
                      ),
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            buildCustomDropdownButtonFormField(
                              fillCollor: Colors.grey[700],
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
                  Column(
                    children: mapMedidasParaChartData(medidas, idArea)
                        .reversed
                        .map((item) {
                      debugPrint(item.toString());

                      DateTime data =
                          DateTime.fromMicrosecondsSinceEpoch(item[0]);
                      String dataFormatada =
                          "${data.day}/${data.month}/${data.year}";
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomRowText(
                            indicador: 'Data:',
                            valor: dataFormatada,
                          ),
                          CustomRowText(
                            indicador: 'Medição',
                            valor: '${item[1]}',
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
