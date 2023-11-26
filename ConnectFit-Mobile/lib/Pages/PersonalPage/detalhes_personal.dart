import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Shared/Blocs/APIs/Get/get_profissionais.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Blocs/APIs/Post/post_contrato.dart';
import 'package:projeto/Shared/Blocs/globals.dart';
import 'package:projeto/Shared/Blocs/funcos_datas.dart';
import 'package:projeto/Shared/Widgets/custom_dropdown_button_form_field.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';

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
  int idDuracao = 1;
  List<Map<String, dynamic>> seedDuracoes = [];
  Map<String, dynamic> profissional = {};
  List<String> especialidadesDesc = [];
  late int idPessoaProfissional;

  criarContratoPressed() async {
    http.Response response = await Contratos.criarContrato(
      idPessoaProfissional,
      idDuracao,
    );

    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 201) {
      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        if (mounted) {
          errorSnackBar(context, responseMap.values.first[0]);
        }
      }
    }
  }

  Future<void> loadData() async {
    await FetchProfissonais.fetchProfissional(widget.id).then((data) {
      setState(() {
        profissional = data;
        idPessoaProfissional = profissional["User"]['id'];
      });
      for (var lista in profissional['Especialidades']) {
        for (var especialidade in lista) {
          especialidadesDesc.add(especialidade['descricao']);
        }
      }
    });
    await FetchData.fetchDuracao().then((data) {
      setState(() {
        seedDuracoes = data;
        isLoading = false;
      });
    });
  }

  void onChangedDuracao(int newValue) {
    setState(() {
      idDuracao = newValue;
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
                flexibleSpace: Column(
                  children: [
                    const SizedBox(height: 25),
                    ProfilePicture(
                      name: profissional["User"]['name'],
                      radius: 80,
                      fontsize: 50,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: profissional["User"]['name'],
                      fontSize: 15,
                    )
                  ],
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
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Idade',
                        valor:
                            "${CalcularIdade.calcularIdade(profissional["Pessoa"]["dataNas"])} anos",
                      ),
                      const SizedBox(height: 10),
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Valor',
                        valor:
                            'R\$ ${profissional["PessoaProfissional"]["valor"]}',
                      ),
                      const SizedBox(height: 10),
                      CustomRowText(
                        color: Colors.brancoBege,
                        indicador: 'Registro',
                        valor:
                            '${profissional["PessoaProfissional"]["numReg"]}',
                      ),
                      const SizedBox(height: 10),
                      CustomRowTextVariosItens(
                        indicador: "Especialidades",
                        textos: especialidadesDesc.join(', '),
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
                  child: GlobalCustomElevatedButton(
                      onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              backgroundColor: Colors.pretoPag,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const CustomText(
                                      text: 'Selecine a duração contrato:',
                                      fontSize: 15,
                                    ),
                                    const SizedBox(height: 30),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: buildCustomDropdownButtonFormField(
                                        data: seedDuracoes,
                                        value: idDuracao,
                                        onChanged: onChangedDuracao,
                                        labelText: 'Duração',
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    GlobalCustomElevatedButton(
                                      width: 150,
                                      onPressed: () => criarContratoPressed(),
                                      child: const CustomText(
                                        text: "Criar contrato",
                                        isBold: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
