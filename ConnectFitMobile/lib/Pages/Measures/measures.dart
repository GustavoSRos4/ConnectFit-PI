import 'package:flutter/material.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class MeasuresPage extends StatefulWidget {
  const MeasuresPage({super.key});

  @override
  State<MeasuresPage> createState() => _MeasuresPageState();
}

class _MeasuresPageState extends State<MeasuresPage> {
  final pesoEC = TextEditingController();
  final percentualEC = TextEditingController();
  final subescapularEC = TextEditingController();
  final tricepsEC = TextEditingController();
  final peitoralEC = TextEditingController();
  final axilarMediaEC = TextEditingController();
  final supraIliacaEC = TextEditingController();
  final abdominalEC = TextEditingController();
  final femuralMediaEC = TextEditingController();
  MedidasModel? model;

  void testeDados() {
    setState(() {
      model = MedidasModel(
          peso: pesoEC.text,
          abdominal: abdominalEC.text,
          axilarMedia: abdominalEC.text,
          femuralMedia: femuralMediaEC.text,
          peitoral: peitoralEC.text,
          percentual: percentualEC.text,
          subescapular: subescapularEC.text,
          supraIliaca: supraIliacaEC.text,
          triceps: tricepsEC.text);
    });
    debugPrint(model!.peso);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: CustomText(
            text: "Medidas",
            isBold: true,
          ),
          actions: [],
        ),
        body: Column(
          children: [
            MedidasButton(
              nomeMedida: "Peso",
              valorMedida: model?.peso ?? 'Não definido',
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
                          controller: pesoEC,
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            testeDados();
                            Navigator.pop(context);
                          },
                          child: const Text('Inserir'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            MedidasButton(
              nomeMedida: "Percentual de Gordura",
              valorMedida: model?.percentual ?? 'Não definido',
              onPressed: () => {},
            ),
            MedidasButton(
              nomeMedida: "Subescapular",
              valorMedida: model?.subescapular ?? 'Não definido',
              onPressed: () => {},
            ),
            MedidasButton(
              nomeMedida: "Triceps",
              valorMedida: model?.triceps ?? 'Não definido',
              onPressed: () => {},
            ),
            MedidasButton(
              nomeMedida: "Peitoral",
              valorMedida: model?.peitoral ?? 'Não definido',
              onPressed: () => {},
            ),
            MedidasButton(
              nomeMedida: "Axilar Media",
              valorMedida: model?.axilarMedia ?? 'Não definido',
              onPressed: () => {},
            ),
            MedidasButton(
              nomeMedida: "SupraIliaca",
              valorMedida: model?.supraIliaca ?? 'Não definido',
              onPressed: () => {},
            ),
            MedidasButton(
              nomeMedida: "Abdominal",
              valorMedida: model?.abdominal ?? 'Não definido',
              onPressed: () => {},
            ),
            MedidasButton(
              nomeMedida: "FemuralMedia",
              valorMedida: model?.femuralMedia ?? 'Não definido',
              onPressed: () => {},
            ),
          ],
        ));
  }
}

class MedidasButton extends StatelessWidget {
  final String nomeMedida;
  final String valorMedida;
  final void Function() onPressed;
  const MedidasButton({
    super.key,
    required this.nomeMedida,
    required this.valorMedida,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                CustomText(text: "$nomeMedida: ", isBold: true, fontSize: 15),
                CustomText(text: valorMedida, isBold: false, fontSize: 15),
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
