import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';

class PerfilChangePassword extends StatelessWidget {
  const PerfilChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: Text('Alterar Senha'),
        actions: [],
      ),
    );
  }
}
