import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';

class PerfilEditDados extends StatelessWidget {
  const PerfilEditDados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Editar Dados'),
        actions: [],
      ),
      body: Container(
        width: 500,
      ),
    );
  }
}
