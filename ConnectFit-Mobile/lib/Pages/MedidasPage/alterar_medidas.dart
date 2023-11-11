import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:projeto/Shared/Blocs/APIs/create_medida.dart';
import 'package:projeto/Shared/Blocs/APIs/globals.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_container_title_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_elevated_button.dart';
import 'package:projeto/Shared/Widgets/custom_list_tile_alterar_medidas.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:http/http.dart' as http;

class PageMedidasAlterar extends StatefulWidget {
  const PageMedidasAlterar({super.key});

  @override
  State<PageMedidasAlterar> createState() => _PageMedidasAlterarState();
}

class _PageMedidasAlterarState extends State<PageMedidasAlterar> {
  final abdominalEC = TextEditingController();
  final axilarMediaEC = TextEditingController();
  final femuralMediaEC = TextEditingController();
  final peitoralEC = TextEditingController();
  final percentualGorduraEC = TextEditingController();
  final pesoEC = TextEditingController();
  final subescapularEC = TextEditingController();
  final supraIliacaEC = TextEditingController();
  final tricepsEC = TextEditingController();
  List<Map<String, String>> areas = [];
  MedidasModel? model;

  salvarPressed() async {
    int peso = int.parse(pesoEC.text);
    int percentualGordura = int.parse(percentualGorduraEC.text);
    int subescapular = int.parse(subescapularEC.text);
    int triceps = int.parse(tricepsEC.text);
    int peitoral = int.parse(peitoralEC.text);
    int axilarMedia = int.parse(axilarMediaEC.text);
    int supraIliaca = int.parse(supraIliacaEC.text);
    int abdominal = int.parse(abdominalEC.text);
    int femuralMedia = int.parse(femuralMediaEC.text);

    http.Response response = await ApiMedidas.registrarMedidas(
      peso,
      percentualGordura,
      subescapular,
      triceps,
      peitoral,
      axilarMedia,
      supraIliaca,
      abdominal,
      femuralMedia,
      areas,
    );

    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (mounted) {
        Navigator.pushNamed(context, '/threeInfos');
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
  }

  testeDados(String nome) {
    setState(() {
      model = MedidasModel(
        abdominal: abdominalEC.text,
        axilarMedia: axilarMediaEC.text,
        femuralMedia: femuralMediaEC.text,
        peitoral: peitoralEC.text,
        percentual: percentualGorduraEC.text,
        peso: pesoEC.text,
        subescapular: subescapularEC.text,
        supraIliaca: supraIliacaEC.text,
        triceps: tricepsEC.text,
      );
    });
    debugPrint(model.toString());
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
              const SizedBox(height: 30),
              const CustomContainerTitlePerfil(text: 'Composição Corporal'),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Axilar Media",
                valorMedida: model?.axilarMedia ?? '',
                dataAlteracao: "10/11/2023",
                controller: axilarMediaEC,
                funcao: () => testeDados("axilarMediaEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "FemuralMedia",
                valorMedida: model?.femuralMedia ?? '',
                dataAlteracao: "15/11/2023",
                controller: femuralMediaEC,
                funcao: () => testeDados("femuralMediaEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Percentual de Gordura",
                valorMedida: model?.percentual ?? '',
                dataAlteracao: "10/09/2023",
                controller: percentualGorduraEC,
                funcao: () => testeDados("percentualGorduraEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Peso",
                valorMedida: model?.peso ?? '',
                dataAlteracao: "10/10/2023",
                controller: pesoEC,
                funcao: () => testeDados("pesoEC"),
              ),
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Dobras Cutâneas'),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Subescapular",
                valorMedida: model?.subescapular ?? '',
                dataAlteracao: "10/11/2023",
                controller: subescapularEC,
                funcao: () => testeDados("subescapularEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "SupraIliaca",
                valorMedida: model?.supraIliaca ?? '',
                dataAlteracao: "10/11/2023",
                controller: supraIliacaEC,
                funcao: () => testeDados("supraIliacaEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Triceps",
                valorMedida: model?.triceps ?? '',
                dataAlteracao: "10/11/2023",
                controller: tricepsEC,
                funcao: () => testeDados("tricepsEC"),
              ),
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Cirunferência e Tamanho'),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Peitoral",
                valorMedida: model?.peitoral ?? '',
                dataAlteracao: "10/11/2023",
                controller: peitoralEC,
                funcao: () => testeDados("peitoralEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Abdominal",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "10/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Outros'),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Ombros",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "09/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Tórax",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "10/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Abdômen",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "11/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Cintura",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "12/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Quadril",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "13/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Braço Esquerdo",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "14/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Braço Direito",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "15/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Coxa Esquerda",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "16/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Perna Esquerda",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "17/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomListTileAlterarMedidas(
                nomeMedida: "Perna Direita",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "17/11/2023",
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
              CustomElevatedButton(
                onPressed: () => salvarPressed,
                child: const CustomText(text: 'Mandar', color: Colors.red),
              ),
            ],
          ),
        ));
  }
}
