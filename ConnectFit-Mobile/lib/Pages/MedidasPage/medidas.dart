import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/create_medida.dart';
import 'package:projeto/Shared/Blocs/APIs/globals.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_container_title_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_elevated_button.dart';
import 'package:projeto/Shared/Widgets/custom_outlined_button_medidas.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:http/http.dart' as http;

class PageMedidas extends StatefulWidget {
  const PageMedidas({super.key});

  @override
  State<PageMedidas> createState() => _PageMedidasState();
}

class _PageMedidasState extends State<PageMedidas> {
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
          title: Text("Medidas"),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/alterarMedidas'),
                child: const CustomText(
                  text: "Alterar",
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const CustomContainerTitlePerfil(text: 'Composição Corporal'),
              const SizedBox(height: 10),
              CustomOutlinedButtonMedidas(
                nomeMedida: "Axilar Media",
                valorMedida: model?.axilarMedia ?? '',
                controller: axilarMediaEC,
                funcao: () => testeDados("axilarMediaEC"),
              ),
              CustomOutlinedButtonMedidas(
                nomeMedida: "FemuralMedia",
                valorMedida: model?.femuralMedia ?? '',
                controller: femuralMediaEC,
                funcao: () => testeDados("femuralMediaEC"),
              ),
              CustomOutlinedButtonMedidas(
                nomeMedida: "Percentual de Gordura",
                valorMedida: model?.percentual ?? '',
                controller: percentualGorduraEC,
                funcao: () => testeDados("percentualGorduraEC"),
              ),
              CustomOutlinedButtonMedidas(
                nomeMedida: "Peso",
                valorMedida: model?.peso ?? '',
                controller: pesoEC,
                funcao: () => testeDados("pesoEC"),
              ),
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Dobras Cutâneas'),
              const SizedBox(height: 20),
              CustomOutlinedButtonMedidas(
                nomeMedida: "Subescapular",
                valorMedida: model?.subescapular ?? '',
                controller: subescapularEC,
                funcao: () => testeDados("subescapularEC"),
              ),
              CustomOutlinedButtonMedidas(
                nomeMedida: "SupraIliaca",
                valorMedida: model?.supraIliaca ?? '',
                controller: supraIliacaEC,
                funcao: () => testeDados("supraIliacaEC"),
              ),
              CustomOutlinedButtonMedidas(
                nomeMedida: "Triceps",
                valorMedida: model?.triceps ?? '',
                controller: tricepsEC,
                funcao: () => testeDados("tricepsEC"),
              ),
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Cirunferência e Tamanho'),
              const SizedBox(height: 20),
              CustomOutlinedButtonMedidas(
                nomeMedida: "Peitoral",
                valorMedida: model?.peitoral ?? '',
                controller: peitoralEC,
                funcao: () => testeDados("peitoralEC"),
              ),
              CustomOutlinedButtonMedidas(
                nomeMedida: "Abdominal",
                valorMedida: model?.abdominal ?? '',
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
