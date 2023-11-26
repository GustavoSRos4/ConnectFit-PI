import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class PerfilSobreApp extends StatelessWidget {
  const PerfilSobreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        actions: [],
        title: Text('Sobre o Aplicativo'),
      ),
      body: Column(
        children: [
          CustomText(
              fontSize: 15,
              text:
                  "App desenvolvido por estudantes do 4º período de Sistemas de Informação. Uma criação dedicada para o Projeto Integrador, combinando esforços e conhecimentos para oferecer uma solução única e inovadora."),
        ],
      ),
    );
  }
}
