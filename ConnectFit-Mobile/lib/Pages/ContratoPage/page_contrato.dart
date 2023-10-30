import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';

class PageContrato extends StatefulWidget {
  const PageContrato({super.key});

  @override
  State<PageContrato> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PageContrato> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: Text('Contratos'),
        actions: [],
      ),
      body: Center(
        child: Icon(
          Icons.add_alert_sharp,
          size: 300,
        ),
      ),
    );
  }
}
