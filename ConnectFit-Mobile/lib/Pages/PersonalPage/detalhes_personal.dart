import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/row_custom_text.dart';

class DetalhesPersonal extends StatefulWidget {
  const DetalhesPersonal({super.key});

  @override
  State<DetalhesPersonal> createState() => _DetalhesPersonalState();
}

class _DetalhesPersonalState extends State<DetalhesPersonal> {
  var personal = [
    {
      'nome': 'Joao Vitor',
      'idade': 23,
      'cidade': 'Patos de minas',
      'especialidade': 'Perda de peso',
      'valor': '100,00',
      'descricao':
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,'
    },
    {
      'nome': 'Henrique',
      'idade': 29,
      'cidade': 'Patos de minas',
      'especialidade': 'Ganho de massa',
      'valor': '120,00',
      'descricao':
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,'
    },
    {
      'nome': 'Gustavo',
      'idade': 20,
      'cidade': 'Patos de minas',
      'especialidade': 'Perda de peso',
      'valor': '70,00',
      'descricao':
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,'
    },
    {
      'nome': 'Ezequiel',
      'idade': 24,
      'cidade': 'Pindaibas',
      'especialidade': 'Ganho de massa',
      'valor': '200,00',
      'descricao':
          'Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos,'
    },
  ];

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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.vertical(
                bottom: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/fotoAleatoria.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                RowCustomText(
                  color: Colors.brancoBege,
                  indicador: 'Nome',
                  valor: '${personal[0]['nome']}',
                ),
                const SizedBox(height: 10),
                RowCustomText(
                  color: Colors.brancoBege,
                  indicador: 'Idade',
                  valor: '${personal[0]['idade']}',
                ),
                const SizedBox(height: 10),
                RowCustomText(
                  color: Colors.brancoBege,
                  indicador: 'Cidade',
                  valor: '${personal[0]['cidade']}',
                ),
                const SizedBox(height: 10),
                RowCustomText(
                  color: Colors.brancoBege,
                  indicador: 'Valor',
                  valor: '${personal[0]['valor']}',
                ),
                const SizedBox(height: 10),
                RowCustomText(
                  color: Colors.brancoBege,
                  indicador: 'Especialidade',
                  valor: '${personal[0]['especialidade']}',
                ),
                ExpansionTile(
                  collapsedIconColor: Colors.brancoBege,
                  iconColor: Colors.brancoBege,
                  tilePadding: const EdgeInsets.all(0),
                  title: const CustomText(
                    fontSize: 13.5,
                    color: Colors.brancoBege,
                    text: 'Descrição',
                    isBold: true,
                  ),
                  children: [
                    SizedBox(
                      height: 80,
                      child: SingleChildScrollView(
                        child: CustomText(
                          fontSize: 13.5,
                          color: Colors.brancoBege,
                          text: '${personal[0]['descricao']}',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
                onPressed: () {},
                child: const CustomText(
                  fontSize: 13.5,
                  text: 'Solicitar',
                  isBold: true,
                )),
          )
        ],
      ),
    );
  }
}
