import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/create_medida.dart';
import 'package:projeto/Shared/Blocs/APIs/globals.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_container_title_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_list_tile_medidas.dart';

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
              SizedBox(
                height: 60,
                width: double.infinity,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/alterarMedidas'),
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
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Composição Corporal'),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Axilar Media",
                valorMedida: model?.axilarMedia ?? '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "FemuralMedia",
                valorMedida: model?.femuralMedia ?? '',
                dataAlteracao: "15/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Percentual de Gordura",
                valorMedida: model?.percentual ?? '',
                dataAlteracao: "10/09/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Peso",
                valorMedida: model?.peso ?? '',
                dataAlteracao: "10/10/2023",
              ),
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Dobras Cutâneas'),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Subescapular",
                valorMedida: model?.subescapular ?? '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "SupraIliaca",
                valorMedida: model?.supraIliaca ?? '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Triceps",
                valorMedida: model?.triceps ?? '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Cirunferência e Tamanho'),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Peitoral",
                valorMedida: model?.peitoral ?? '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Abdominal",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              const CustomContainerTitlePerfil(text: 'Outros'),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Ombros",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "09/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Tórax",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Abdômen",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "11/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Cintura",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "12/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Quadril",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "13/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Braço Esquerdo",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "14/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Braço Direito",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "15/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Coxa Esquerda",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "16/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Perna Esquerda",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "17/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: "Perna Direita",
                valorMedida: model?.abdominal ?? '',
                dataAlteracao: "17/11/2023",
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}

class TesteExpansion extends StatelessWidget {
  final String text;
  final List<Widget> children;
  const TesteExpansion({
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
