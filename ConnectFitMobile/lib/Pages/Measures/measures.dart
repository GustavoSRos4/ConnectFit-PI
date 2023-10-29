import 'package:flutter/material.dart';
import 'package:projeto/Pages/PerfilPage/perfil.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class MeasuresPage extends StatefulWidget {
  const MeasuresPage({super.key});

  @override
  State<MeasuresPage> createState() => _MeasuresPageState();
}

class _MeasuresPageState extends State<MeasuresPage> {
  final abdominalEC = TextEditingController();
  final axilarMediaEC = TextEditingController();
  final femuralMediaEC = TextEditingController();
  final peitoralEC = TextEditingController();
  final percentualEC = TextEditingController();
  final pesoEC = TextEditingController();
  final subescapularEC = TextEditingController();
  final supraIliacaEC = TextEditingController();
  final tricepsEC = TextEditingController();
  MedidasModel? model;

  testeDados(String nome) {
    setState(() {
      model = MedidasModel(
        abdominal: abdominalEC.text,
        axilarMedia: axilarMediaEC.text,
        femuralMedia: femuralMediaEC.text,
        peitoral: peitoralEC.text,
        percentual: percentualEC.text,
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
              const ContainerTitlePerfil(text: 'Composição Corporal'),
              const SizedBox(height: 10),
              MedidasButton(
                nomeMedida: "Axilar Media",
                valorMedida: model?.axilarMedia ?? '',
                controller: axilarMediaEC,
                funcao: () => testeDados("axilarMediaEC"),
              ),
              MedidasButton(
                nomeMedida: "FemuralMedia",
                valorMedida: model?.femuralMedia ?? '',
                controller: femuralMediaEC,
                funcao: () => testeDados("femuralMediaEC"),
              ),
              MedidasButton(
                nomeMedida: "Percentual de Gordura",
                valorMedida: model?.percentual ?? '',
                controller: percentualEC,
                funcao: () => testeDados("percentualEC"),
              ),
              MedidasButton(
                nomeMedida: "Peso",
                valorMedida: model?.peso ?? '',
                controller: pesoEC,
                funcao: () => testeDados("pesoEC"),
              ),
              const SizedBox(height: 10),
              const ContainerTitlePerfil(text: 'Dobras Cutâneas'),
              const SizedBox(height: 20),
              MedidasButton(
                nomeMedida: "Subescapular",
                valorMedida: model?.subescapular ?? '',
                controller: subescapularEC,
                funcao: () => testeDados("subescapularEC"),
              ),
              MedidasButton(
                nomeMedida: "SupraIliaca",
                valorMedida: model?.supraIliaca ?? '',
                controller: supraIliacaEC,
                funcao: () => testeDados("supraIliacaEC"),
              ),
              MedidasButton(
                nomeMedida: "Triceps",
                valorMedida: model?.triceps ?? '',
                controller: tricepsEC,
                funcao: () => testeDados("tricepsEC"),
              ),
              const SizedBox(height: 10),
              const ContainerTitlePerfil(text: 'Cirunferência e Tamanho'),
              const SizedBox(height: 20),
              MedidasButton(
                nomeMedida: "Peitoral",
                valorMedida: model?.peitoral ?? '',
                controller: peitoralEC,
                funcao: () => testeDados("peitoralEC"),
              ),
              MedidasButton(
                nomeMedida: "Abdominal",
                valorMedida: model?.abdominal ?? '',
                controller: abdominalEC,
                funcao: () => testeDados("abdominalEC"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}

class MedidasButton extends StatelessWidget {
  final String nomeMedida;
  final String valorMedida;
  final TextEditingController controller;
  final void Function() funcao;
  const MedidasButton({
    super.key,
    required this.nomeMedida,
    required this.valorMedida,
    required this.controller,
    required this.funcao,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: OutlinedButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CustomText(
                    text: 'Insira a nova medida:',
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  TextField(
                    controller: controller,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      funcao();
                      Navigator.pop(context);
                    },
                    child: const Text('Inserir'),
                  ),
                ],
              ),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                CustomText(text: "$nomeMedida: ", isBold: true),
                CustomText(text: valorMedida, isBold: false),
              ],
            ),
            const Icon(
              Icons.create_outlined,
              color: Colors.brancoBege,
            )
          ],
        ),
      ),
    );
  }
}
