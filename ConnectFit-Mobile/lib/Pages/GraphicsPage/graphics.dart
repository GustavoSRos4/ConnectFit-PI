import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_dropdown_button_form_field.dart';
import 'package:projeto/Shared/Widgets/Charts/line_chart.dart';
import 'package:projeto/Pages/GraphicsPage/data.dart';

class GraphicsPage extends StatefulWidget {
  const GraphicsPage({Key? key}) : super(key: key);

  @override
  State<GraphicsPage> createState() => _GraphicsPageState();
}

class _GraphicsPageState extends State<GraphicsPage> {
  late Future<List<Map<String, dynamic>>> seedAreas;
  final int idTeste = 2;

  @override
  void initState() {
    super.initState();
    seedAreas = FetchData.fetchAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text(
          'Gráficos',
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepOrange,
                  style: BorderStyle.solid,
                  width: 10,
                ),
                color: Colors.deepOrange[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: seedAreas,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No data available');
                      } else {
                        return Column(
                          children: [
                            buildCustomDropdownButtonFormField(
                              menuMaxHeight: 300,
                              data: snapshot.data!,
                              value: idTeste,
                              onChanged: (a) {},
                              labelText: 'Medida',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyLineChart(points: chartData)
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
