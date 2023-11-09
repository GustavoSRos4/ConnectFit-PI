import 'package:flutter/material.dart';

DropdownButtonFormField<int> buildCustomDropdownButtonFormField({
  required List<Map<String, dynamic>> data,
  required int value,
  required Function(int) onChanged,
  required String labelText,
}) {
  return DropdownButtonFormField<int>(
    borderRadius: BorderRadius.circular(15),
    value: value,
    onChanged: (int? newValue) {
      onChanged(newValue!);
    },
    items: data.map<DropdownMenuItem<int>>((item) {
      return DropdownMenuItem<int>(
        value: item['id'],
        child: Text(item['Descricao']),
      );
    }).toList(),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.brancoBege,
      hintStyle: const TextStyle(color: Colors.white),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      contentPadding: const EdgeInsets.all(17),
      labelText: labelText,
    ),
  );
}
