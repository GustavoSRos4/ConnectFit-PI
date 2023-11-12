import 'dart:convert';

import 'package:flutter/material.dart';

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
        //Navigator.pushNamed(context, '/threeInfos');
        Navigator.pop(context);
        debugPrint("Deu certo 201");
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
  }

  testeDados(String medida, String id) {
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

  @override
  void initState() {
    super.initState();

    FetchData.fetchAreas().then((data) {
      debugPrint('Areas: $data');
      setState(() {
        seedAreas = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text("Atualizar Medidas"),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CustomContainerTitlePerfil(text: 'Corpo'),
              const SizedBox(height: 20),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(1),
                valorMedida: percentualGorduraEC.text,
                dataAlteracao: "10/09/2023",
                controller: percentualGorduraEC,
                funcao: () => testeDados(percentualGorduraEC.text, '1'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(2),
                valorMedida: pesoEC.text,
                dataAlteracao: "10/10/2023",
                controller: pesoEC,
                funcao: () => testeDados(pesoEC.text, '2'),
              ),
              const SizedBox(height: 20),
              const CustomContainerTitlePerfil(text: 'Dobras'),
              const SizedBox(height: 20),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(17),
                valorMedida: axilarMediaEC.text,
                dataAlteracao: "10/11/2023",
                controller: axilarMediaEC,
                funcao: () => testeDados(axilarMediaEC.text, '17'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(20),
                valorMedida: femuralMediaEC.text,
                dataAlteracao: "15/11/2023",
                controller: femuralMediaEC,
                funcao: () => testeDados(femuralMediaEC.text, '20'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(14),
                valorMedida: model?.subescapular ?? '',
                dataAlteracao: "10/11/2023",
                controller: subescapularEC,
                funcao: () => testeDados(subescapularEC.text, '14'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(18),
                valorMedida: model?.supraIliaca ?? '',
                dataAlteracao: "10/11/2023",
                controller: supraIliacaEC,
                funcao: () => testeDados(supraIliacaEC.text, '18'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(15),
                valorMedida: model?.triceps ?? '',
                dataAlteracao: "10/11/2023",
                controller: tricepsEC,
                funcao: () => testeDados(tricepsEC.text, '15'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(16),
                valorMedida: model?.peitoral ?? '',
                dataAlteracao: "10/11/2023",
                controller: peitoralEC,
                funcao: () => testeDados(peitoralEC.text, '16'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(19),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "10/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados(abdominalEC.text, '19'),
              ),
              const SizedBox(height: 20),
              const CustomContainerTitlePerfil(text: 'Medidas Fita'),
              const SizedBox(height: 20),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(3),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "09/11/2023",
                controller: ombrosEC,
                funcao: () => testeDados(ombrosEC.text, '3'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(4),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "10/11/2023",
                controller: toraxEC,
                funcao: () => testeDados(toraxEC.text, '4'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(5),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "11/11/2023",
                controller: abdomenEC,
                funcao: () => testeDados(abdomenEC.text, '5'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(6),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "12/11/2023",
                controller: cinturaEC,
                funcao: () => testeDados(cinturaEC.text, '6'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(7),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "13/11/2023",
                controller: quadrilEC,
                funcao: () => testeDados(quadrilEC.text, '7'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(8),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "14/11/2023",
                controller: bracoEsqEC,
                funcao: () => testeDados(bracoEsqEC.text, '8'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(9),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "15/11/2023",
                controller: bracoDirEC,
                funcao: () => testeDados(bracoDirEC.text, '9'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(10),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "16/11/2023",
                controller: coxaEsqEC,
                funcao: () => testeDados(coxaEsqEC.text, '10'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(11),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "16/11/2023",
                controller: coxaDirEC,
                funcao: () => testeDados(coxaDirEC.text, '11'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(12),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "17/11/2023",
                controller: pernaEsqEC,
                funcao: () => testeDados(pernaEsqEC.text, '12'),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: getNameById(13),
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "17/11/2023",
                controller: pernaDirEC,
                funcao: () => testeDados(pernaDirEC.text, '13'),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GlobalCustomElevatedButton(
                      width: 150,
                      onPressed: () => {},
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
