import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';

class PerfilEditFoto extends StatelessWidget {
  const PerfilEditFoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Editar Foto'),
        actions: [],
      ),
      body: Container(
        width: 300,
      ),
    );
  }
}
