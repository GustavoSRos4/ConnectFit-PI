import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_profissionais.dart';
import 'package:projeto/Shared/Blocs/calcular_datas.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';

class DetalhesPersonal extends StatefulWidget {
  final int id;
  const DetalhesPersonal({
    super.key,
    required this.id,
  });

  @override
  State<DetalhesPersonal> createState() => _DetalhesPersonalState();
}

class _DetalhesPersonalState extends State<DetalhesPersonal> {
  bool isLoading = true;
  Map<String, dynamic> profissional = {};
  List<String> especialidadesDesc = [];

  Future<void> loadData() async {
    FetchProfissonais.fetchProfissional(widget.id).then((data) {
      debugPrint('Profissional ${widget.id}: $data,');
      setState(() {
        profissional = data;
        isLoading = false;
      });
      for (var lista in profissional['Especialidades']) {
        for (var especialidade in lista) {
          especialidadesDesc.add(especialidade['descricao']);
        }
      }
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
      appBar: isLoading
          ? null
          : PreferredSize(
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Nome',
                        valor: '${profissional["User"]['name']}',
                      ),
                      const SizedBox(height: 10),
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Idade',
                        valor:
                            "${CalcularIdade.calcularIdade(profissional["Pessoa"]["dataNas"])} anos",
                      ),
                      const SizedBox(height: 10),
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Cidade',
                        valor: '${profissional["Enderecos"][0][0]['idCidade']}',
                      ),
                      const SizedBox(height: 10),
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Valor',
                        valor: '${profissional["PessoaProfissional"]["valor"]}',
                      ),
                      const SizedBox(height: 10),
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Registro',
                        valor:
                            '${profissional["PessoaProfissional"]["numReg"]}',
                      ),
                      const SizedBox(height: 10),
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Especialidade',
                        valor: especialidadesDesc.join(', '),
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
                                text: '${profissional["Pessoa"]['descricao']}',
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
