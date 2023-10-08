import 'package:flutter/material.dart';

class RecuperarSenha extends StatelessWidget {
  const RecuperarSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de recuperar senha"),
      ),
      body: const BodyPasswordRecorvery(),
    );
  }
}

class BodyPasswordRecorvery extends StatefulWidget {
  const BodyPasswordRecorvery({super.key});

  @override
  State<BodyPasswordRecorvery> createState() => _BodyPasswordRecorveryState();
}

class _BodyPasswordRecorveryState extends State<BodyPasswordRecorvery> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Aqui está vazio....",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
