import 'package:flutter/material.dart';

DropdownButtonFormField<int> buildCustomDropdownButtonFormField({
  double? menuMaxHeight,
  BorderSide borderSide = BorderSide.none,
  Color? fillCollor = Colors.brancoBege,
  required List<Map<String, dynamic>> data,
  required int? value,
  required Function(int) onChanged,
  required String labelText,
  AutovalidateMode? autovalidateMode = AutovalidateMode.onUserInteraction,
}) {
  return DropdownButtonFormField<int>(
    iconEnabledColor: Colors.brancoBege,
    iconDisabledColor: Colors.brancoBege,
    menuMaxHeight: menuMaxHeight,
    borderRadius: BorderRadius.circular(15),
    dropdownColor: Colors.grey[800],
    value: value,
    onChanged: (int? newValue) {
      onChanged(newValue!);
    },
    items: data.map<DropdownMenuItem<int>>((item) {
      return DropdownMenuItem<int>(
        value: item['id'],
        child: Text(
          item['Descricao'],
          style: const TextStyle(color: Colors.brancoBege),
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
    validator: (int? value) {
      if (value == null) {
        return 'Selecione uma opção.';
      }
      return null;
    },
    autovalidateMode: autovalidateMode,
  );
}
