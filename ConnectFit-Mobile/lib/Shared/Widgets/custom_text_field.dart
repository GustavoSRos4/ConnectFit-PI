import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool readOnly;
  final String label;
  final String? hint;
  final IconData? icon;
  final bool obscureTest;
  final Widget? sufix;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final String? Function(String? text)? validator;
  final void Function()? onTap;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;
  final void Function(String text)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.hint,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.obscureTest = false,
    this.sufix,
    this.inputFormatters,
    this.controller,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    this.suffixIconColor = Colors.brancoBege,
    this.prefixIconColor = Colors.brancoBege,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: keyboardType,
      onTap: onTap,
      readOnly: readOnly,
      onFieldSubmitted: onFieldSubmitted,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureTest,
      style: const TextStyle(color: Colors.brancoBege),
      decoration: InputDecoration(
        counterStyle: const TextStyle(
          color: Colors.brancoBege,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        filled: true,
        fillColor: Colors.grey[800],
        labelStyle: const TextStyle(color: Colors.brancoBege),
        hintStyle: const TextStyle(color: Colors.brancoBege),
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
              ),
        prefixIconColor: prefixIconColor,
        suffixIcon: sufix,
        suffixIconColor: suffixIconColor,
      ),
    );
  }
}
