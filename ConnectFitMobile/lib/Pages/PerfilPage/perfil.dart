import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          primary: false,
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          flexibleSpace: const Column(
            children: [
              SizedBox(height: 35),
              Image(
                height: 140,
                image: AssetImage('assets/images/iconePerfil.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "João Vitor Pereira Sousa",
                style: TextStyle(
                    color: Colors.begeclaro,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
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
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.begeclaro,
          ),
          const Column(
            children: [
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
      color: Colors.pretoPag,
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
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
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
            Text(text),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
