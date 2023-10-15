import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          flexibleSpace: const Image(
            alignment: Alignment.bottomCenter,
            image: AssetImage('assets/images/iconePerfil.png'),
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
      body: Stack(
        children: <Widget>[
          const Column(
            children: [
              SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      text: 'João Vitor Pereira Sousa',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              ContainerTitlePerfil(text: 'Opções Gerais'),
              ListTilePerfil(text: 'Alterar senha'),
              ContainerTitlePerfil(text: 'Informações'),
              ListTilePerfil(text: 'Sobre o aplicativo'),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 25,
            child: TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text('Sair do aplicativo'),
                    SizedBox(width: 10),
                    Icon(Icons.logout),
                  ],
                )),
          )
        ],
      ),
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
              fontSize: 18,
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
              fontSize: 17,
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
