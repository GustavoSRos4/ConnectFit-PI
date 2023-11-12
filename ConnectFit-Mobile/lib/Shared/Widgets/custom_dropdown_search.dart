import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

/// Um widget personalizado para DropdownSearch.
///
/// Este widget encapsula a funcionalidade do DropdownSearch e permite
/// selecionar um item de uma lista de itens.
class CustomDropdownSearch extends StatelessWidget {
  /// O rótulo exibido no campo de texto do dropDown.
  final String labelPrincipal;

  /// O rótulo exibido no campo de texto do Search.
  final String labelSecundaria;

  /// O texto de sugestão exibido no campo de texto do dropdown.
  final String hintTextPrincipal;

  /// O texto de sugestão exibido no campo de texto do Seach.
  final String hintTextSecundaria;

  /// O ícone exibido no início do campo de texto.
  final Widget prefixIcon;

  /// O item selecionado atualmente.
  ///
  /// Este é um [Map] que representa o item selecionado no dropdown.
  /// Se nenhum item estiver selecionado, este valor será `null`.
  final Map<String, dynamic>? selectedItem;

  /// A lista de itens que podem ser selecionados.
  ///
  /// Esta é uma lista de [Map]s, onde cada [Map] representa um item que pode ser selecionado no dropdown.
  final List<Map<String, dynamic>> items;

  /// Uma função de callback que é chamada quando um item é selecionado.
  ///
  /// Esta função é chamada com o novo item selecionado sempre que o usuário seleciona um item no dropdown.
  /// Se o usuário não selecionou um item, a função é chamada com `null`.
  final Function(Map<String, dynamic>? newItem)? onChanged;
  final String Function(Map<String, dynamic>) itemAsString;
  final Color? fillColor;
  final Color? prefixIconColor;

  const CustomDropdownSearch({
    Key? key,
    this.selectedItem,
    required this.items,
    required this.onChanged,
    required this.labelPrincipal,
    required this.hintTextPrincipal,
    required this.prefixIcon,
    required this.labelSecundaria,
    required this.hintTextSecundaria,
    required this.itemAsString,
    this.fillColor,
    this.prefixIconColor = Colors.brancoBege,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, dynamic>>(
      selectedItem: selectedItem,
      popupProps: PopupProps.menu(
        itemBuilder: (context, item, isSelected) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: CustomText(
              text: itemAsString(item),
              fontSize: 15,
            ),
          );
        },
        menuProps: MenuProps(
          backgroundColor: Colors.grey[800],
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          style: const TextStyle(color: Colors.brancoBege),
          padding: const EdgeInsets.all(15.0),
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.brancoBege),
            label: Text(labelSecundaria),
            hintStyle: const TextStyle(color: Colors.brancoBege),
            hintText: hintTextSecundaria,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
        ),
      ),
      items: items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(
          color: Colors.brancoBege,
          fontSize: 15,
        ),
        dropdownSearchDecoration: InputDecoration(
          suffixIconColor: Colors.brancoBege,
          prefixIcon: prefixIcon,
          prefixIconColor: prefixIconColor,
          fillColor: fillColor ?? Colors.grey[800],
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          labelStyle: const TextStyle(color: Colors.brancoBege),
          labelText: labelPrincipal,
          hintText: hintTextPrincipal,
          hintStyle: const TextStyle(color: Colors.brancoBege),
        ),
      ),
      onChanged: onChanged,
      itemAsString: itemAsString,
    );
  }
}
