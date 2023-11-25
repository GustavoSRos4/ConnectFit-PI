import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';

class CustomListTileAlterarMedidas extends StatefulWidget {
  final String dataAlteracao;
  final String nomeMedida;
  final String valorMedida;
  final String textUnidadeMedida;
  final TextEditingController controller;
  final void Function() funcao;

  const CustomListTileAlterarMedidas({
    super.key,
    required this.nomeMedida,
    required this.valorMedida,
    required this.controller,
    required this.funcao,
    required this.dataAlteracao,
    required this.textUnidadeMedida,
  });

  @override
  State<CustomListTileAlterarMedidas> createState() =>
      _CustomListTileAlterarMedidasState();
}

class _CustomListTileAlterarMedidasState
    extends State<CustomListTileAlterarMedidas> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          ListTile(
            tileColor: Colors.grey[800],
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.grey[800],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: 'Inserir medida ${widget.nomeMedida}:',
                          color: Colors.brancoBege,
                          fontSize: 15,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          inputBorder: const UnderlineInputBorder(),
                          autofocus: true,
                          controller: widget.controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onFieldSubmitted: (z) {
                            if (formKey.currentState!.validate()) {
                              widget.funcao();
                              widget.controller.clear();
                              Navigator.pop(context);
                            }
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Esse campo não pode ficar vazio";
                            }
                            if (double.parse(text) <= 0) {
                              return "Esse campo não pode ser zero";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        GlobalCustomElevatedButton(
                          height: 40,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              widget.funcao();
                              widget.controller.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: const CustomText(
                            text: 'Inserir',
                            isBold: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            title: CustomText(
              text: widget.nomeMedida,
              fontSize: 15,
              isBold: true,
            ),
            subtitle: CustomRowText(
              indicador: 'Alteração',
              valor: widget.dataAlteracao,
            ),
            trailing: const Icon(
              Icons.create_outlined,
              color: Colors.brancoBege,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 60,
            top: 0,
            child: Center(
              child: CustomText(
                text: '${widget.valorMedida} ${widget.textUnidadeMedida}',
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
