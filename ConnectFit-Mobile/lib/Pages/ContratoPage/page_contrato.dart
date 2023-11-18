import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_contratos.dart';
import 'package:projeto/Shared/Blocs/calcular_datas.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';

class PageContrato extends StatefulWidget {
  const PageContrato({super.key});

  @override
  State<PageContrato> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageContrato> {
  bool isLoading = true;
  List<Map<String, dynamic>> contratos = [];

  Future<void> loadData() async {
    FetchContratos.fetchContratos().then((data) {
      debugPrint('Contratos: $data');
      setState(() {
        contratos = data;
        isLoading = false;
      });
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
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
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
                        itemCount: contratos.length,
                        itemBuilder: (context, index) {
                          var contrato = contratos[index];
                          var idProfissional = contrato["idPessoaProfissional"];
                          var createdAt = contrato["created_at"];
                          var valor = contrato["valor"];
                          return InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            splashColor: Colors.brancoBege,
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Colors.grey[800],
                                child: Row(
                                  children: <Widget>[
                                    const SizedBox(width: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Personal',
                                            valor: '$idProfissional',
                                          ),
                                          const SizedBox(height: 5),
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Data Inicio',
                                            valor: FormatarDatas.formatarData(
                                                createdAt),
                                          ),
                                          const SizedBox(height: 5),
                                          CustomRowText(
                                            fontSize: 13.5,
                                            indicador: 'Valor cobrado',
                                            valor: 'R\$ $valor',
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
            ),
    );
  }
}
