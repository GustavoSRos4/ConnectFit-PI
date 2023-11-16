import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Blocs/date_format.dart';

class FormDetails extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String nomeExercicio;
  const FormDetails({
    super.key,
    required this.data,
    required this.nomeExercicio,
  });

  @override
  State<FormDetails> createState() => _FormDetailsState();
}

class _FormDetailsState extends State<FormDetails> {
  DateTime now = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(widget.nomeExercicio),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 30,
          left: 30,
          top: 15,
          bottom: 15,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: '${dateFormat(now)}',
                  fontSize: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.date_range,
                    size: 35,
                  ),
                  color: Colors.brancoBege,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  child: _buildPanel(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: const EdgeInsets.all(0),
      children: widget.data.map<ExpansionPanelRadio>(
        (exercicio) {
          return ExpansionPanelRadio(
            value: exercicio["idExercicio"],
            canTapOnHeader: true,
            backgroundColor: Colors.grey[800],
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: CustomText(
                    isBold: true, text: exercicio["Descricao"], fontSize: 17),
              );
            },
            body: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.bege,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    height: 100,
                    child: const Center(
                      child: Text('VIDEO'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomRowText(
                    indicador: 'Repetições',
                    valor: '${exercicio["Repeticoes"]}',
                  ),
                  const SizedBox(height: 10),
                  CustomRowText(
                    indicador: 'Descanso',
                    valor: '${exercicio["descanso"]}',
                  ),
                  const SizedBox(height: 10),
                  CustomRowText(
                    indicador: 'Carga',
                    valor: '${exercicio["carga"]}',
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
