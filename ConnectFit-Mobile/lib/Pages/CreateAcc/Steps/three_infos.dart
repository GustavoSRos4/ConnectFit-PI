import 'package:flutter/material.dart';

import 'package:projeto/Shared/Blocs/APIs/globals.dart';
import 'package:projeto/Shared/Blocs/APIs/seeds.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/positioned_float_action_button.dart';

class ThreeInfos extends StatefulWidget {
  const ThreeInfos({super.key});

  @override
  State<ThreeInfos> createState() => _ThreeInfosState();
}

class _ThreeInfosState extends State<ThreeInfos> {
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
      debugPrint('ConsumoAlc: $data');
      setState(() {
        dataConsumoAlc = data;
      });
    });

    FetchData.fetchObjetivos().then((data) {
      debugPrint('Objetivos: $data');
      setState(() {
        dataObjetivos = data;
      });
    });

    FetchData.fetchNivelAtiFis().then((data) {
      debugPrint('NivelAtiFis: $data');
      setState(() {
        dataNivelAtiFis = data;
      });
    });
    FetchData.fetchFumante().then((data) {
      debugPrint('Fumante: $data');
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
                            child: buildDropdownButtonFormField(
                                data: dataConsumoAlc,
                                value: idConsumoAlc,
                                onChanged: onChangedConsumoAlc,
                                labelText: 'Consumo Alcoólico'),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: buildDropdownButtonFormField(
                                data: dataFumante,
                                value: idFumante,
                                onChanged: onChangedFumante,
                                labelText: 'Você fuma?'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      buildDropdownButtonFormField(
                          data: dataObjetivos,
                          value: idObjetivo,
                          onChanged: onChangedObjetivo,
                          labelText: 'Objetivo'),
                      const SizedBox(height: 15),
                      buildDropdownButtonFormField(
                          data: dataNivelAtiFis,
                          value: idNivelAtiFis,
                          onChanged: onChangedNivelAtiFis,
                          labelText: 'Nível de Atividade Fisica'),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
          PositionedActionButton(onPressed: () {}),
        ],
      ),
    );
  }
}

DropdownButtonFormField<int> buildDropdownButtonFormField({
  required List<Map<String, dynamic>> data,
  required int value,
  required Function(int) onChanged,
  required String labelText,
}) {
  return DropdownButtonFormField<int>(
    borderRadius: BorderRadius.circular(15),
    value: value,
    onChanged: (int? newValue) {
      onChanged(newValue!);
    },
    items: data.map<DropdownMenuItem<int>>((item) {
      return DropdownMenuItem<int>(
        value: item['id'],
        child: Text(item['Descricao']),
      );
    }).toList(),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.brancoBege,
      hintStyle: const TextStyle(color: Colors.white),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      contentPadding: const EdgeInsets.all(17),
      labelText: labelText,
    ),
  );
}

PopupMenuButton<int> buildPopupMenuButton({
  required List<Map<String, dynamic>> data,
  required int value,
  required Function(int) onChanged,
  required String labelText,
}) {
  return PopupMenuButton<int>(
    itemBuilder: (context) => data.map((item) {
      return PopupMenuItem<int>(
        value: item['id'],
        child: Text(item['Descricao']),
      );
    }).toList(),
    onSelected: (int newValue) {
      onChanged(newValue);
    },
  );
}
