import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/positioned_float_action_button.dart';

class ThreeInfos extends StatefulWidget {
  const ThreeInfos({super.key});

  @override
  State<ThreeInfos> createState() => _ThreeInfosState();
}

class _ThreeInfosState extends State<ThreeInfos> {
  final alturaEC = TextEditingController();
  final pesoEC = TextEditingController();
  int? idFumante;
  int? idNivelAtiFis;
  int idObjetivo = 1;
  int? idConsumoAlc;

  var objetivos = [
    {'id': '1', 'Descricao': 'Perda de peso'},
    {'id': '2', 'Descricao': 'Ganho de massa muscular'},
    {'id': '3', 'Descricao': 'Aumento da força'},
    {'id': '4', 'Descricao': 'Melhoria da postura'},
    {'id': '5', 'Descricao': 'Definição muscular'},
  ];

  void onChanged(int newValue) {
    debugPrint("$newValue");
    setState(() {
      idObjetivo = newValue;
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
                              hint: "Digite o seu peso...",
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
                              hint: "Digite a sua altura...",
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
                      buildDropdownButtonFormField(
                          data: objetivos,
                          value: idObjetivo,
                          onChanged: onChanged,
                          labelText: 'Objetivo'),
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
        value: int.parse(item['id']),
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
        value: int.parse(item['id']),
        child: Text(item['Descricao']),
      );
    }).toList(),
    onSelected: (int newValue) {
      onChanged(newValue);
    },
  );
}
