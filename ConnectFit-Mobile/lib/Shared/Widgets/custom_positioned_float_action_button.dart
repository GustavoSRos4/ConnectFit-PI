import 'package:flutter/material.dart';

class CustomPositionedActionButton extends StatelessWidget {
  final void Function() onPressed;
  const CustomPositionedActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 17,
      bottom: 17,
      child: FloatingActionButton(
        elevation: 5,
        onPressed: onPressed,
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
