import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';

Container customContainerTextFieldAddVariousItens({
  required String textTitulo,
  required void Function(String) onFieldSubmitted,
  required TextEditingController? controller,
  required String label,
  required void Function() onPressedButton,
  required List<Widget> childrenChip,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    child: Column(
      children: [
        CustomText(
          text: textTitulo,
          color: Colors.brancoBege,
          fontSize: 15,
          isBold: true,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                onFieldSubmitted: onFieldSubmitted,
                controller: controller,
                label: label,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            GlobalCustomElevatedButton(
              height: 40,
              width: 60,
              borderRadius: 50,
              onPressed: onPressedButton,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: childrenChip,
        ),
      ],
    ),
  );
}
