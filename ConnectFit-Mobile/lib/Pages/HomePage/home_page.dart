import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_nome_usuario.dart';
import 'package:projeto/Shared/Blocs/date_format.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  String nomeUsuario = '';
  bool isLoading = true;

  Future<void> loadData() async {
    await FetchNomeUsuario.fetchNomeUsuario().then((data) {
      setState(() {
        nomeUsuario = data;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  List<String> mensagensIncentivo = [
    "Você é mais forte do que pensa. Continue assim!",
    "Cada gota de suor leva você mais perto dos seus objetivos.",
    "Seja consistente. Grandes resultados vêm com o tempo.",
    "Seu corpo pode fazer tudo; é só a sua mente que você precisa convencer.",
    "A jornada de mil milhas começa com um único passo. Você já deu o seu?",
    "Não conte os dias, faça os dias contarem.",
    "A persistência é o caminho do êxito. Continue persistindo!",
    "Você não tem que ser extremamente talentoso, apenas extremamente dedicado.",
    "Sua única limitação é você mesmo. Supere!",
    "Cada treino é uma vitória contra a preguiça e a procrastinação.",
    "Pequenos progressos são ainda progressos. Celebre cada um deles!",
    "Acredite em si mesmo e tudo será possível.",
    "O sucesso não é acidental, é trabalho árduo e determinação.",
    "A dor que você sente hoje será a força que você sente amanhã.",
    "Não se compare aos outros. Compare-se à pessoa que era ontem.",
    "A disciplina é a ponte entre metas e realizações.",
    "Você está mais perto do que estava ontem. Continue!",
    "Nunca é tarde para começar. O importante é começar agora!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLoading
          ? null
          : CustomAppBar(
              automaticallyImplyLeading: false,
              title: Text("Olá, $nomeUsuario"),
              actions: const [],
            ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        top: 20.5, right: 20.5, left: 20.5),
                    decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    height: 230,
                    width: double.infinity,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30.5, left: 20),
                    child: GlobalCustomElevatedButton(
                      color: Colors.pretoPag,
                      height: 220,
                      width: double.infinity,
                      onPressed: () {
                        debugPrint(DateTime.now().toString());
                      },
                      child: Stack(
                        children: [
                          Center(
                            child: CustomText(
                                textAlign: TextAlign.center,
                                fontSize: 20,
                                text: mensagensIncentivo[Random()
                                    .nextInt(mensagensIncentivo.length)]),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomText(
                                text: '${dateFormat(now)}',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GlobalCustomElevatedButton(
                            height: 80,
                            width: 150,
                            onPressed: () {
                              Navigator.pushNamed(context, '/trainingList');
                            },
                            child: const CustomText(
                              text: 'Treinos',
                              isBold: true,
                              fontSize: 20,
                            ),
                          ),
                          GlobalCustomElevatedButton(
                            height: 80,
                            width: 150,
                            onPressed: () {
                              Navigator.pushNamed(context, '/graphics');
                            },
                            child: const CustomText(
                              text: 'Gráficos',
                              isBold: true,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GlobalCustomElevatedButton(
                            height: 80,
                            width: 150,
                            onPressed: () {
                              Navigator.pushNamed(context, '/measures');
                            },
                            child: const CustomText(
                              text: 'Medidas',
                              isBold: true,
                              fontSize: 20,
                            ),
                          ),
                          GlobalCustomElevatedButton(
                            height: 80,
                            width: 150,
                            onPressed: () {
                              Navigator.pushNamed(context, '/ranking');
                            },
                            child: const CustomText(
                              text: 'Ranking',
                              isBold: true,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]),
    );
  }
}
