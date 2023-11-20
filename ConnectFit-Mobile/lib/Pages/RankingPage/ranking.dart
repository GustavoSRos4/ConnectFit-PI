import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: Text('Rankings'),
        actions: [],
      ),
      body: Center(
          child: CustomText(
        text: 'Em desenvolvimento...',
        fontSize: 20,
        isBold: true,
      )),
    );
  }
}
