import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: Text('Buscar Personal'),
        actions: [],
      ),
      body: Center(
        child: Icon(
          Icons.text_snippet_outlined,
          size: 150,
        ),
      ),
    );
  }
}
