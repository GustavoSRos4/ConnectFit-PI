import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class CustomCircularProfileAvatar extends StatelessWidget {
  final String text;
  final double radius;
  final double? fontSize;
  const CustomCircularProfileAvatar({
    super.key,
    required this.text,
    this.radius = 80,
    this.fontSize = 40,
  });

  String pegarIniciais(String nome) {
    List<String> nomes = nome.split(" ");

    String initials = "";
    if (nomes.isNotEmpty) {
      initials = nomes[0][0].toUpperCase();

      if (nomes.length > 1) {
        initials += nomes[1][0].toUpperCase();
      }
    }
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      elevation: 5,
      '',
      radius: radius,
      backgroundColor: Colors.transparent,
      initialsText: Text(
        pegarIniciais(text),
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.brancoBege,
        ),
      ),
      borderColor: Colors.brown,
      showInitialTextAbovePicture: true,
    );
  }
}
