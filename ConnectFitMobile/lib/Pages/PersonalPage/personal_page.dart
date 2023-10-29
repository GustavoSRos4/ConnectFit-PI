import 'package:flutter/material.dart';

import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/row_custom_text.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
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
        appBar: const CustomAppBar(
          automaticallyImplyLeading: false,
          title: Text('Buscar Personal'),
          actions: [],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 15,
                    bottom: 15,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: SizedBox(
                          height: 25,
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              filled: true,
                              fillColor: Colors.brancoBege,
                              labelText: 'Buscar',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.brancoBege,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.filter_alt),
                        color: Colors.brancoBege,
                        iconSize: 30,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 30, left: 30),
                                    decoration: const BoxDecoration(
                                      color: Colors.pretoPag,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.brancoBege,
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context)),
                                        ),
                                        const SizedBox(height: 10),
                                        RowCustomText(
                                          color: Colors.brancoBege,
                                          indicador: 'Nome',
                                          valor: '${personal[index]['nome']}',
                                        ),
                                        const SizedBox(height: 10),
                                        RowCustomText(
                                          color: Colors.brancoBege,
                                          indicador: 'Idade',
                                          valor: '${personal[index]['idade']}',
                                        ),
                                        const SizedBox(height: 10),
                                        RowCustomText(
                                          color: Colors.brancoBege,
                                          indicador: 'Cidade',
                                          valor: '${personal[index]['cidade']}',
                                        ),
                                        const SizedBox(height: 10),
                                        RowCustomText(
                                          color: Colors.brancoBege,
                                          indicador: 'Valor',
                                          valor: '${personal[index]['valor']}',
                                        ),
                                        const SizedBox(height: 10),
                                        RowCustomText(
                                          color: Colors.brancoBege,
                                          indicador: 'Especialidade',
                                          valor:
                                              '${personal[index]['especialidade']}',
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
                                                  text:
                                                      '${personal[index]['descricao']}',
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
                              );
                            },
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.deepOrange,
                          child: Row(
                            children: <Widget>[
                              const SizedBox(width: 3),
                              const Image(
                                image: AssetImage(
                                    'assets/images/fotoPersonal.png'),
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RowCustomText(
                                      indicador: 'Nome',
                                      valor: '${personal[index]['nome']}',
                                    ),
                                    RowCustomText(
                                      indicador: 'Idade',
                                      valor: '${personal[index]['idade']} anos',
                                    ),
                                    RowCustomText(
                                      indicador: 'Cidade',
                                      valor: '${personal[index]['cidade']}',
                                    ),
                                    RowCustomText(
                                      indicador: 'Especialidade',
                                      valor:
                                          '${personal[index]['especialidade']}',
                                    ),
                                    RowCustomText(
                                      indicador: 'Valor cobrado',
                                      valor: 'R\$ ${personal[index]['valor']}',
                                    ),

                                    // Adicione mais Text widgets aqui para mais campos
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
