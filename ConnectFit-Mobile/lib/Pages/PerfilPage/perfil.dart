import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:projeto/Pages/LoginPage/login.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_nome_usuario.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_dados_usuario.dart';
import 'package:projeto/Shared/Widgets/custom_container_title_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_list_tile_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String nome = '';
  Map<String, dynamic> dadosUsuario = {};
  Map<String, dynamic> seedAnamnese = {};
  List<Map<String, dynamic>> dataConsumoAlc = [];
  List<Map<String, dynamic>> dataObjetivos = [];
  List<Map<String, dynamic>> dataFumante = [];
  List<Map<String, dynamic>> dataNivelAtiFis = [];
  List<String> medicamentoDescricao = [];
  List<String> comorbidadeDescricao = [];
  bool isLoading = true;

  String getNameById(int id, List<Map<String, dynamic>> data) {
    for (Map<String, dynamic> area in data) {
      if (area['id'] == id) {
        return area['Descricao'];
      }
    }
    return '';
  }

  Future<void> loadData() async {
    await FetchNomeUsuario.fetchNomeUsuario().then((data) {
      debugPrint('Nome usuario: $data');
      setState(() {
        nome = data;
      });
    });

    await FetchDadosUsuario.fetchDadosUsuario().then((data) {
      debugPrint('Dados: $data');
      setState(() {
        dadosUsuario = data;
      });
      for (var medicamento in dadosUsuario['Medicamentos']) {
        // Adicionar a descrição do medicamento à lista
        medicamentoDescricao.add(medicamento['descricao']);
      }
      for (var comorbidade in dadosUsuario['Comorbidades']) {
        // Adicionar a descrição do medicamento à lista
        comorbidadeDescricao.add(comorbidade['descricao']);
      }
    });

    await FetchData.fetchConsumoAlc().then((data) {
      debugPrint('Dados asdasd : $data');
      setState(() {
        dataConsumoAlc = data;
      });
    });

    await FetchData.fetchObjetivos().then((data) {
      setState(() {
        dataObjetivos = data;
      });
    });

    await FetchData.fetchNivelAtiFis().then((data) {
      setState(() {
        dataNivelAtiFis = data;
      });
    });
    await FetchData.fetchFumante().then((data) {
      setState(() {
        dataFumante = data;
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
      backgroundColor: Colors.pretoPag,
      appBar: isLoading
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: AppBar(
                automaticallyImplyLeading: false,
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
                      name: nome,
                      radius: 80,
                      fontsize: 50,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: nome,
                      fontSize: 15,
                    )
                  ],
                ),
                actions: const [],
              ),
            ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, bottom: 20, right: 20),
                    child: Column(
                      children: [
                        CustomRowText(
                          indicador: 'Altura',
                          valor: dadosUsuario['PessoaUsuario'] != null &&
                                  dadosUsuario['PessoaUsuario']['Altura'] !=
                                      null
                              ? '${dadosUsuario['PessoaUsuario']['Altura']} cm'
                              : '',
                        ),
                        const SizedBox(height: 10),
                        CustomRowText(
                          indicador: 'Objetivo',
                          valor: dadosUsuario['PessoaUsuario'] != null
                              ? getNameById(
                                  dadosUsuario['PessoaUsuario']['idObjetivo'],
                                  dataObjetivos)
                              : '',
                        ),
                        const SizedBox(height: 10),
                        CustomRowText(
                          indicador: 'Fumante',
                          valor: dadosUsuario['PessoaUsuario'] != null
                              ? getNameById(
                                  dadosUsuario['PessoaUsuario']['idFumante'],
                                  dataFumante)
                              : '',
                        ),
                        const SizedBox(height: 10),
                        CustomRowText(
                          indicador: 'Nivel de Atividade',
                          valor: dadosUsuario['PessoaUsuario'] != null
                              ? getNameById(
                                  dadosUsuario['PessoaUsuario']
                                      ['idNivelAtiFis'],
                                  dataNivelAtiFis)
                              : '',
                        ),
                        const SizedBox(height: 10),
                        CustomRowText(
                          indicador: 'Consumo alcoolico',
                          valor: dadosUsuario['PessoaUsuario'] != null
                              ? getNameById(
                                  dadosUsuario['PessoaUsuario']['idConsumoAlc'],
                                  dataConsumoAlc)
                              : '',
                        ),
                        const SizedBox(height: 10),
                        CustomRowTextVariosItens(
                          indicador: 'Medicamentos',
                          textos: dadosUsuario['PessoaUsuario'] != null
                              ? medicamentoDescricao.join(', ')
                              : '',
                        ),
                        const SizedBox(height: 10),
                        CustomRowTextVariosItens(
                          indicador: 'Comorbidades',
                          textos: dadosUsuario['PessoaUsuario'] != null
                              ? comorbidadeDescricao.join(', ')
                              : '',
                        ),
                        const SizedBox(height: 10),
                        ExpansionTile(
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          tilePadding: const EdgeInsets.only(right: 0),
                          title: const CustomText(
                            text: 'Descrição:',
                            isBold: true,
                            fontSize: 13.5,
                          ),
                          children: [
                            CustomText(
                              fontSize: 13.5,
                              text: dadosUsuario['Pessoa'] != null &&
                                      dadosUsuario['Pessoa']['descricao'] !=
                                          null
                                  ? '${dadosUsuario['Pessoa']['descricao']}'
                                  : '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const CustomContainerTitlePerfil(text: 'Informações'),
                  CustomListTilePerfil(
                    text: 'Sobre o aplicativo',
                    onTap: () =>
                        Navigator.pushNamed(context, '/perfilSobreApp'),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: TextButton(
                      onPressed: () async {
                        bool saiu = await sair();
                        if (saiu) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        }
                      },
                      child: const IntrinsicWidth(
                        child: Row(
                          children: [
                            CustomText(
                              text: 'Sair do aplicativo',
                              color: Colors.deepOrange,
                              fontSize: 13.5,
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.logout),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }
}

Future<bool> sair() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  return true;
}
