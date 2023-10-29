import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class ListTilePerfil extends StatelessWidget {
  final String text;
  const ListTilePerfil({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Padding(
        padding: const EdgeInsets.only(left: 15),
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
