import 'package:flutter/material.dart';

class PageContrato extends StatefulWidget {
  const PageContrato({super.key});

  @override
  State<PageContrato> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageContrato> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.add_alert_sharp,
        size: 300,
      ),
    );
  }
}
