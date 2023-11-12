import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';

class CustomListTileAlterarMedidas extends StatelessWidget {
  final String dataAlteracao;
  final String nomeMedida;
  final String valorMedida;
  final TextEditingController controller;
  final void Function() funcao;
  const CustomListTileAlterarMedidas({
    super.key,
    required this.nomeMedida,
    required this.valorMedida,
    required this.controller,
    required this.funcao,
    required this.dataAlteracao,
  });

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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomText(
                        text: 'Inserir medida $nomeMedida:',
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSubmitted: (z) {
                          funcao();
                          Navigator.pop(context);
                        },
                        keyboardType: TextInputType.number,
                        controller: controller,
                        autofocus: true,
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          funcao();
                          Navigator.pop(context);
                        },
                        child: const Text('Inserir'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: CustomText(
              text: nomeMedida,
              fontSize: 15,
              isBold: true,
            ),
            subtitle: CustomRowText(
              indicador: 'Alteração',
              valor: dataAlteracao,
            ),
            trailing: const Icon(
              Icons.create_outlined,
              color: Colors.brancoBege,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                width: 1,
                color: Colors.brancoBege,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 60,
            top: 0,
            child: Center(
              child: CustomText(
                text: '$valorMedida cm',
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
