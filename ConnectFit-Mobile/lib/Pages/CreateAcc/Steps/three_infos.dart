import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/positioned_float_action_button.dart';

class ThreeInfos extends StatefulWidget {
  const ThreeInfos({super.key});

  @override
  State<ThreeInfos> createState() => _ThreeInfosState();
}

class _ThreeInfosState extends State<ThreeInfos> {
  final alturaEC = TextEditingController();
  final pesoEC = TextEditingController();
  final bebidaEC = TextEditingController();
  final medicamentoEC = TextEditingController();
  final comorbidadeEC = TextEditingController();
  final objetivoEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: <Widget>[
          ListView(
            children: [
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomTextField(
                        label: "Altura",
                        icon: Icons.person,
                        hint: "Digite a sua altura...",
                        controller: alturaEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "Peso",
                              icon: Icons.person,
                              hint: "Digite o seu peso...",
                              controller: pesoEC,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Esse campo não pode ficar vazio";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomTextField(
                              label: "Bebida",
                              icon: Icons.person,
                              hint: "Sim , não...",
                              controller: bebidaEC,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Esse campo não pode ficar vazio";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Quais medicamentos você toma?",
                        icon: Icons.person,
                        hint: "Digite seus medicamentos...",
                        controller: medicamentoEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Comorbidades",
                        icon: Icons.person,
                        hint: "Digite as suas comorbidades...",
                        controller: comorbidadeEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: "Objetivo",
                        icon: Icons.person,
                        hint: "Digite seu objetivo em treinar...",
                        controller: objetivoEC,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Esse campo não pode ficar vazio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
          PositionedActionButton(onPressed: () {}),
        ],
      ),
    );
  }
}
