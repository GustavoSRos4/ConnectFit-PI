import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

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
  final Function(Map<String, dynamic>? novaCidade)? onChanged;
  final String Function(Map<String, dynamic>) itemAsString;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, dynamic>>(
      selectedItem: selectedItem,
      popupProps: PopupProps.menu(
        menuProps: const MenuProps(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          padding: const EdgeInsets.all(15.0),
          decoration: InputDecoration(
            label: Text(labelPrincipal),
            hintText: hintTextPrincipal,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
        ),
      ),
      items: items,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          prefixIcon: prefixIcon,
          fillColor: Colors.brancoBege,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          labelText: labelSecundaria,
          hintText: hintTextSecundaria,
        ),
      ),
      onChanged: onChanged,
      itemAsString: itemAsString,
    );
  }
}
