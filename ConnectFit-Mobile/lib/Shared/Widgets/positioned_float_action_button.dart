import 'package:flutter/material.dart';

class PositionedActionButton extends StatelessWidget {
  final void Function() onPressed;
  const PositionedActionButton({super.key, required this.onPressed});

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
