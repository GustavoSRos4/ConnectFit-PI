import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class CustomOutlinedButtonMedidas extends StatelessWidget {
  final String nomeMedida;
  final String valorMedida;
  final TextEditingController controller;
  final void Function() funcao;
  const CustomOutlinedButtonMedidas({
    super.key,
    required this.nomeMedida,
    required this.valorMedida,
    required this.controller,
    required this.funcao,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: OutlinedButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CustomText(
                    text: 'Insira a nova medida:',
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  TextField(
                    controller: controller,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                CustomText(
                  text: "$nomeMedida: ",
                  isBold: true,
                  fontSize: 13.5,
                ),
                CustomText(
                  text: valorMedida,
                  isBold: false,
                  fontSize: 13.5,
                ),
              ],
            ),
            const Icon(
              Icons.create_outlined,
              color: Colors.brancoBege,
            )
          ],
        ),
      ),
    );
  }
}
