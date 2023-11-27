import 'package:flutter/material.dart';
import 'package:projeto/Pages/PersonalPage/detalhes_personal.dart';
import 'package:projeto/Shared/Blocs/APIs/Get/get_profissionais.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_circular_profile_avatar.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  List<Map<String, dynamic>> profissionais = [];
  List<Map<String, dynamic>> filteredProfissionais = [];
  Future<void> loadData() async {
    await FetchProfissonais.fetchAllProfissionais().then((data) {
      setState(() {
        profissionais = data;
        filteredProfissionais = data;
        isLoading = false;
      });
    });
  }

  void filterByName(String query) {
    setState(() {
      filteredProfissionais = profissionais
          .where((profissional) => profissional["User"]["name"]
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
        title: Text('Buscar Personal'),
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredProfissionais.length,
                        itemBuilder: (context, index) {
                          var profissional = filteredProfissionais[index];
                          var userName = profissional["User"]["name"];
                          var id = profissional["User"]["id"];
                          var valor =
                              profissional["PessoaProfissional"]["valor"];
                          List<String> especialidades = [];
                          for (var lista in profissional["Especialidades"]) {
                            for (var especialidade in lista) {
                              especialidades.add(especialidade['descricao']);
                            }
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              tileColor: Colors.grey[800],
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        DetalhesPersonal(id: id),
                                  ),
                                );
                              },
                              contentPadding: const EdgeInsets.all(10.0),
                              leading: CustomCircularProfileAvatar(
                                text: userName.isNotEmpty ? userName : " ",
                                radius: 25,
                                fontSize: 20,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: CustomText(
                                  fontSize: 13.5,
                                  text: userName,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  especialidades.isNotEmpty
                                      ? CustomRowTextVariosItensPersonal(
                                          textos: especialidades.isNotEmpty
                                              ? especialidades.join(', ')
                                              : '',
                                        )
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CustomText(
                                    fontSize: 13.5,
                                    text: 'R\$ $valor',
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
            ),
    );
  }
}
