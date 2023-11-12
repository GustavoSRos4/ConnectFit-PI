import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

DropdownButtonFormField<String> buildCustomDropdownButtonFormFieldSexo({
  double? menuMaxHeight,
  BorderSide borderSide = BorderSide.none,
  Color? fillCollor = Colors.brancoBege,
  required List<Map<String, dynamic>> data,
  required String? value,
  required Function(String) onChanged,
  required String labelText,
}) {
  return DropdownButtonFormField<String>(
    iconEnabledColor: Colors.brancoBege,
    iconDisabledColor: Colors.brancoBege,
    menuMaxHeight: menuMaxHeight,
    borderRadius: BorderRadius.circular(15),
    dropdownColor: Colors.grey[800],
    value: value,
    onChanged: (String? newValue) {
      onChanged(newValue!);
    },
    items: data.map<DropdownMenuItem<String>>((item) {
      return DropdownMenuItem<String>(
        value: item['Sigla'],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              color: Colors.brancoBege,
              item['Descricao'] == 'Feminino' ? Icons.female : Icons.male,
            ),
            const SizedBox(width: 10),
            CustomText(
              text: item['Descricao'] ?? '',
              fontSize: 15,
            ),
          ],
        ),
      );
    }).toList(),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey[800],
      hintStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderSide: borderSide,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      contentPadding: const EdgeInsets.all(17),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.brancoBege),
    ),
  );
}
