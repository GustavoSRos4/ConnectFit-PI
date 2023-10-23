import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class TrainingList extends StatefulWidget {
  const TrainingList({super.key});

  @override
  State<TrainingList> createState() => _TrainingListState();
}

class _TrainingListState extends State<TrainingList> {
  String _selectedStatus = "Todas";

  void _applyFilter(String status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Fichas de treino'),
        actions: [],
      ),
      body: SingleChildScrollView(
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
                              vertical: 10, horizontal: 20),
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
                              color: Colors.begeclaro,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                            ),
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: const Icon(Icons.close),
                                        onPressed: () =>
                                            Navigator.pop(context)),
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: _selectedStatus,
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.filter_list),
                        color: Colors.white,
                        onSelected: _applyFilter,
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'Ativo',
                              child: Text('Ativo'),
                            ),
                            const PopupMenuItem(
                              value: 'Concluido',
                              child: Text('Concluído'),
                            ),
                            const PopupMenuItem(
                              value: 'Todas',
                              child: Text('Todas'),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (_selectedStatus != "Todas" &&
                        _selectedStatus != fichas[index]['status']) {
                      return const SizedBox.shrink(); // Retorna um widget vazio
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.pretoPag,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            color: fichas[index]['status'] == 'Ativo'
                                ? Colors.green
                                : Colors.red,
                            width: 2,
                          ),
                        ),
                        margin: const EdgeInsetsDirectional.only(
                          start: 30,
                          end: 30,
                        ),
                        child: ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          title: CustomText(
                            text: "${fichas[index]['nome']}",
                            isBold: true,
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                  text:
                                      "Início: ${fichas[index]['dataInicio']}"),
                              fichas[index]['dataFim'] != null
                                  ? CustomText(
                                      text: "Fim: ${fichas[index]['dataFim']}")
                                  : const SizedBox.shrink()
                            ],
                          ),
                          children: <Widget>[
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 40, left: 40),
                                  child: Card(
                                    color: Colors.deepOrange,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/formDetails',
                                            arguments: (index + 1));
                                      },
                                      textColor: Colors.white,
                                      title: Text(textos[index]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<String> textos = [
  "Treino A",
  "Treino B",
  "Treino C",
  "Treino D",
  "Treino E",
];

var fichas = [
  {
    'id': 1,
    'nome': "Ficha teeste 1",
    'status': "Ativo",
    'dataInicio': "01/10/2023",
    'dataFim': null
  },
  {
    'id': 2,
    'nome': "Ficha teeste 2",
    'status': "Concluido",
    'dataInicio': "01/08/2023",
    'dataFim': "31/08/2023"
  },
  {
    'id': 3,
    'nome': "Ficha teeste 3",
    'status': "Concluido",
    'dataInicio': "01/09/2023",
    'dataFim': "30/09/2023"
  },
];
