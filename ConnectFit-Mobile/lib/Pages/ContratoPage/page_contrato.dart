import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_contratos.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_profissionais.dart';
import 'package:projeto/Shared/Blocs/funcos_datas.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';

class PageContrato extends StatefulWidget {
  const PageContrato({super.key});

  @override
  State<PageContrato> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageContrato> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  List<Map<String, dynamic>> contratos = [];
  List<Map<String, dynamic>> filteredContratos = [];

  Future<void> loadData() async {
    await FetchContratos.fetchContratos().then((data) async {
      for (var contrato in data) {
        var idProfissional = contrato["idPessoaProfissional"];
        await FetchProfissonais.fetchProfissional(idProfissional)
            .then((profissionalData) {
          var profissionalInfo = {
            'name': profissionalData['User']['name'],
            'numReg': profissionalData['PessoaProfissional']['numReg'],
            'valor': profissionalData['PessoaProfissional']['valor'],
          };

          contrato['DadosProfissional'] = profissionalInfo;
        });
      }

      setState(() {
        debugPrint('$data');
        contratos = data;
        filteredContratos = data;
        isLoading = false;
      });
    });
  }

  String verificarDuracao(idDuracao) {
    if (idDuracao == 1) {
      return '1 mês';
    } else if (idDuracao == 2) {
      return '6 meses';
    } else if (idDuracao == 3) {
      return '12 meses';
    }
    return '';
  }

  String verificarFim(idDuracao, dataInicio) {
    DateTime dataInicioFormatada = DateTime.parse(dataInicio);
    DateTime? dataFim;

    if (idDuracao == 1) {
      dataFim = dataInicioFormatada.add(const Duration(days: 30));
    } else if (idDuracao == 2) {
      dataFim = dataInicioFormatada.add(const Duration(days: 180));
    } else if (idDuracao == 3) {
      dataFim = dataInicioFormatada.add(const Duration(days: 365));
    }

    return FormatarDatas.formatarData(dataFim.toString());
  }

  calcularValorContrato(int idDuracao, v) {
    double valor = double.parse(v);
    double valorTotal = 0;
    if (idDuracao == 1) {
      valorTotal = valor;
    } else if (idDuracao == 2) {
      valorTotal = valor * 6;
    } else if (idDuracao == 3) {
      valorTotal = valor * 12;
    }
    return valorTotal;
  }

  void filterByName(String query) {
    setState(() {
      filteredContratos = contratos
          .where((contrato) => contrato["DadosProfissional"]["User"]["name"]
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
        automaticallyImplyLeading: false,
        title: Text('Contratos'),
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
                    Container(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: contratos.isEmpty
                          ? const Center(
                              child: CustomText(
                                text: 'Você ainda não possui contratos.',
                                color: Colors.brancoBege,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredContratos.length,
                              itemBuilder: (context, index) {
                                var contrato = filteredContratos[index];
                                var createdAt = contrato["created_at"];
                                var valor = contrato["valor"];
                                var nome =
                                    contrato["DadosProfissional"]["name"];
                                var numReg =
                                    contrato["DadosProfissional"]["numReg"];
                                var idDuracao = contrato['idDuracao'];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    color: Colors.grey[800],
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Personal',
                                            valor: '$nome',
                                          ),
                                          const SizedBox(height: 10),
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Registro',
                                            valor: '$numReg',
                                          ),
                                          const SizedBox(height: 10),
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Duração',
                                            valor: verificarDuracao(idDuracao),
                                          ),
                                          const SizedBox(height: 10),
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Valor Total',
                                            valor:
                                                'R\$ ${calcularValorContrato(idDuracao, valor)}',
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomRowText(
                                                fontSize: 13.5,
                                                indicador: 'Inicio',
                                                valor:
                                                    FormatarDatas.formatarData(
                                                        createdAt),
                                              ),
                                              CustomRowText(
                                                fontSize: 13.5,
                                                indicador: 'Fim',
                                                valor: verificarFim(
                                                    idDuracao, createdAt),
                                              ),
                                            ],
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
            ),
    );
  }
}
