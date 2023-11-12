import 'package:flutter/material.dart';

import 'package:projeto/Shared/Blocs/APIs/Get/seeds.dart';
import 'package:projeto/Shared/Models/medidas_model.dart';
import 'package:projeto/Shared/Widgets/custom_container_title_perfil.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_list_tile_medidas.dart';

import 'package:projeto/Shared/Widgets/custom_text.dart';

class PageMedidas extends StatefulWidget {
  const PageMedidas({super.key});

  @override
  State<PageMedidas> createState() => _PageMedidasState();
}

class _PageMedidasState extends State<PageMedidas> {
  List<Map<String, dynamic>> seedAreas = [];

  List<Map<String, String>> areass = [];
  MedidasModel? model;

  String getNameById(int id) {
    for (Map<String, dynamic> area in seedAreas) {
      if (area['id'] == id) {
        return area['Descricao'];
      }
    }
    return '';
  }

  @override
  void initState() {
    super.initState();

    FetchData.fetchAreas().then((data) {
      debugPrint('Areas: $data');
      setState(() {
        seedAreas = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: Text("Medidas"),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/alterarMedidas'),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: "Atualizar Medidas",
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.create,
                          color: Colors.brancoBege,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const CustomContainerTitlePerfil(text: 'Corpo'),
              const SizedBox(height: 20),
              CustomListTileMedidas(
                nomeMedida: getNameById(1),
                valorMedida: '',
                dataAlteracao: "10/09/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(2),
                valorMedida: '',
                dataAlteracao: "10/10/2023",
              ),
              const SizedBox(height: 20),
              const CustomContainerTitlePerfil(text: 'Dobras'),
              const SizedBox(height: 20),
              CustomListTileMedidas(
                nomeMedida: getNameById(17),
                valorMedida: '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(20),
                valorMedida: '',
                dataAlteracao: "15/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(14),
                valorMedida: '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(18),
                valorMedida: '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(15),
                valorMedida: '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(16),
                valorMedida: '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(19),
                valorMedida: '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 20),
              const CustomContainerTitlePerfil(text: 'Medidas Fita'),
              const SizedBox(height: 20),
              CustomListTileMedidas(
                nomeMedida: getNameById(3),
                valorMedida: '',
                dataAlteracao: "09/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(4),
                valorMedida: '',
                dataAlteracao: "10/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(5),
                valorMedida: '',
                dataAlteracao: "11/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(6),
                valorMedida: '',
                dataAlteracao: "12/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(7),
                valorMedida: '',
                dataAlteracao: "13/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(8),
                valorMedida: '',
                dataAlteracao: "14/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(9),
                valorMedida: '',
                dataAlteracao: "15/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(10),
                valorMedida: '',
                dataAlteracao: "16/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(11),
                valorMedida: '',
                dataAlteracao: "16/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(12),
                valorMedida: '',
                dataAlteracao: "17/11/2023",
              ),
              const SizedBox(height: 10),
              CustomListTileMedidas(
                nomeMedida: getNameById(13),
                valorMedida: '',
                dataAlteracao: "17/11/2023",
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}

class TesteExpansion extends StatelessWidget {
  final String text;
  final List<Widget> children;
  const TesteExpansion({
    super.key,
    required this.text,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: (value) {},
      collapsedBackgroundColor: Colors.deepOrange,
      iconColor: Colors.white,
      title: CustomText(
        text: text,
        isBold: true,
        fontSize: 15,
      ),
      children: children,
    );
  }
}
