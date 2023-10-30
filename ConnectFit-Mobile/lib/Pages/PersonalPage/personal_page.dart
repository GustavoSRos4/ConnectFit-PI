import 'package:flutter/material.dart';
import 'package:projeto/Pages/PersonalPage/detalhes_personal.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
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
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        splashColor: Colors.brancoBege,
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const DetalhesPersonal(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            color: Colors.pretoPag,
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 5),
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/fotoAleatoria.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RowCustomText(
                                        fontSize: 13.5,
                                        indicador: 'Nome',
                                        valor: '${personal[index]['nome']}',
                                      ),
                                      const SizedBox(height: 5),
                                      RowCustomText(
                                        fontSize: 13.5,
                                        indicador: 'Cidade',
                                        valor: '${personal[index]['cidade']}',
                                      ),
                                      const SizedBox(height: 5),
                                      RowCustomText(
                                        fontSize: 13.5,
                                        indicador: 'Especialidade',
                                        valor:
                                            '${personal[index]['especialidade']}',
                                      ),
                                      const SizedBox(height: 5),
                                      RowCustomText(
                                        fontSize: 13.5,
                                        indicador: 'Valor cobrado',
                                        valor:
                                            'R\$ ${personal[index]['valor']}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
