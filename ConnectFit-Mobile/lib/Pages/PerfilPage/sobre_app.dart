import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';

class PerfilSobreApp extends StatelessWidget {
  const PerfilSobreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        actions: [],
        title: Text('Sobre o Aplicativo'),
      ),
    );
  }
}
