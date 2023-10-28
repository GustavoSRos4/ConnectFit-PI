import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pretoPag,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          flexibleSpace: const Column(
            children: [
              SizedBox(height: 20),
              Image(
                alignment: Alignment.bottomCenter,
                image: AssetImage('assets/images/iconePerfil.png'),
              ),
              CustomText(
                text: "João Vitor Pereira Sousa",
                fontSize: 18,
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.create_outlined),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 30, bottom: 20),
              child: Column(
                children: [
                  RowPerfilDados(indicador: 'Peso', valor: '70 kg'),
                  SizedBox(height: 10),
                  RowPerfilDados(indicador: 'Altura', valor: '180 cm'),
                  SizedBox(height: 10),
                  RowPerfilDados(
                    indicador: 'Medicamentos',
                    valor: 'Dorflex',
                  ),
                  SizedBox(height: 10),
                  RowPerfilDados(
                    indicador: 'Comorbidades',
                    valor: 'bico de pagagaio, Ernia',
                  ),
                  SizedBox(height: 10),
                  RowPerfilDados(
                    indicador: 'Objetivo',
                    valor: 'Descrição, Descrição, Descrição',
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            const ContainerTitlePerfil(text: 'Opções Gerais'),
            const ListTilePerfil(text: 'Alterar senha'),
            const ContainerTitlePerfil(text: 'Informações'),
            const ListTilePerfil(text: 'Sobre o aplicativo'),
            const SizedBox(height: 50),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: () {},
                child: const IntrinsicWidth(
                  child: Row(
                    children: [
                      Text('Sair do aplicativo'),
                      SizedBox(width: 10),
                      Icon(Icons.logout),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class RowPerfilDados extends StatelessWidget {
  final String indicador;
  final String valor;

  const RowPerfilDados({
    super.key,
    required this.indicador,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: '$indicador:',
          isBold: true,
          fontSize: 15,
        ),
        const SizedBox(
          width: 7,
        ),
        CustomText(text: valor),
      ],
    );
  }
}

class ContainerTitlePerfil extends StatelessWidget {
  final String text;
  const ContainerTitlePerfil({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      height: 50,
      width: double.infinity,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}

class ListTilePerfil extends StatelessWidget {
  final String text;
  const ListTilePerfil({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: text,
              fontSize: 15,
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
