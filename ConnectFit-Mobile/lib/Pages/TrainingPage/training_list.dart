import 'package:flutter/material.dart';
import 'package:projeto/Pages/TrainingPage/form_details.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_fichas.dart';
import 'package:projeto/Shared/Blocs/funcos_datas.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';

class TrainingList extends StatefulWidget {
  const TrainingList({super.key});

  @override
  State<TrainingList> createState() => _TrainingListState();
}

class _TrainingListState extends State<TrainingList> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = "Todas";
  List<Map<String, dynamic>> fichas = [];
  List<Map<String, dynamic>> filteredFichas = [];
  bool isLoading = true;

  void _applyFilter(String status) {
    setState(() {
      _selectedStatus = status;
      _filterByStatus();
    });
  }

  void _filterByStatus() {
    setState(() {
      if (_selectedStatus == 'Todas') {
        filteredFichas = fichas;
      } else if (_selectedStatus == "Ativo") {
        filteredFichas =
            fichas.where((ficha) => ficha['Ficha']['dataFim'] == null).toList();
      } else {
        filteredFichas =
            fichas.where((ficha) => ficha['Ficha']['dataFim'] != null).toList();
      }
    });
  }

  Future<void> loadData() async {
    await FetchFichas.fetchFichas().then((data) {
      setState(() {
        fichas = data;
      });
    });

    await FetchFichas.fetchExercicio().then((data) {
      Map<int, String> exerciciosMap = {};
      for (var exercicio in data) {
        exerciciosMap[exercicio['idExercicio']] = exercicio['Nome'];
      }

      setState(() {
        for (var ficha in fichas) {
          ficha['Treinos'].forEach((treino) {
            treino['Exercicios'].forEach((exercicio) {
              int idExercicio = exercicio['idExercicio'];
              exercicio['Nome'] = exerciciosMap[idExercicio] ?? "";
            });
          });
        }
        filteredFichas = fichas;
        isLoading = false;
      });
    });
  }

  void filterByName(String query) {
    setState(() {
      filteredFichas = fichas
          .where((ficha) => ficha["Ficha"]["nomeFicha"]
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Fichas de treino'),
        actions: [],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
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
                      child: SizedBox(
                        height: 35,
                        child: CustomTextField(
                          label: 'Buscar',
                          onChanged: (query) {
                            filterByName(query);
                          },
                          controller: _searchController,
                        ),
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
                                isBold: true,
                              ),
                              PopupMenuButton<String>(
                                icon: const Icon(
                                  Icons.filter_list,
                                  color: Colors.brancoBege,
                                ),
                                color: Colors.grey[800],
                                onSelected: _applyFilter,
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 'Ativo',
                                      child: CustomText(
                                        text: 'Ativo',
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'Concluido',
                                      child: CustomText(
                                        text: 'Concluído',
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'Todas',
                                      child: CustomText(
                                        text: 'Todas',
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                        fichas.isEmpty
                            ? const Center(
                                child: CustomText(
                                  text:
                                      'Você ainda não possui fichas. Solicie um personal.',
                                  color: Colors.brancoBege,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredFichas.length,
                                itemBuilder: (context, index) {
                                  var ficha = filteredFichas[index];
                                  var descricaoFicha =
                                      ficha["Ficha"]["nomeFicha"];
                                  var dataFim = ficha["Ficha"]["dataFim"];
                                  var dataInicio = ficha["Ficha"]["created_at"];
                                  var treinos = ficha["Treinos"];
                                  // if (_selectedStatus != "Todas" &&
                                  //     _selectedStatus !=
                                  //         fichas[index]['status']) {
                                  //   return const SizedBox
                                  //       .shrink(); // Retorna um widget vazio
                                  // }
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.pretoPag,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          color: CalculosDatas.checarDataisNull(
                                                  dataFim)
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
                                          text: descricaoFicha,
                                          isBold: true,
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                text:
                                                    "Início: ${FormatarDatas.formatarData(dataInicio)}"),
                                            dataFim != null
                                                ? CustomText(
                                                    text:
                                                        "Fim: ${FormatarDatas.formatarData(dataFim)}")
                                                : const SizedBox.shrink()
                                          ],
                                        ),
                                        children: <Widget>[
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: treinos.length,
                                            itemBuilder: (context, index) {
                                              var treino = treinos[index];
                                              String descricaoTreino =
                                                  treino["Treino"]["Descricao"];
                                              List<Map<String, dynamic>>
                                                  exercicios =
                                                  treino["Exercicios"];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15,
                                                    left: 15,
                                                    bottom: 15),
                                                child: Card(
                                                  color: Colors.grey[800],
                                                  child: ListTile(
                                                    onTap: () {
                                                      Navigator.push<void>(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              FormDetails(
                                                            data: exercicios,
                                                            nomeExercicio:
                                                                descricaoTreino,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    textColor: Colors.white,
                                                    title:
                                                        Text(descricaoTreino),
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
            ),
    );
  }
}
