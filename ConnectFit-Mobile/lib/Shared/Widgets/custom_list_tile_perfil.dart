import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class CustomListTilePerfil extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CustomListTilePerfil({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              fontSize: 13.5,
              text: text,
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
