import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_row_text.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class CustomListTileMedidas extends StatelessWidget {
  final String dataAlteracao;
  final String nomeMedida;
  final String valorMedida;

  const CustomListTileMedidas({
    super.key,
    required this.nomeMedida,
    required this.valorMedida,
    required this.dataAlteracao,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        tileColor: Colors.grey[800],
        title: CustomText(
          text: nomeMedida,
          fontSize: 15,
          isBold: true,
        ),
        subtitle: CustomRowText(
          indicador: 'Alteração',
          valor: dataAlteracao,
        ),
        trailing: const CustomText(
          text: '10 cm',
          fontSize: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            width: 1,
            color: Colors.brancoBege,
          ),
        ),
      ),
    );
  }
}
