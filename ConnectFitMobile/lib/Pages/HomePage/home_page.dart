import 'package:flutter/material.dart';
import 'package:projeto/Shared/Blocs/date_format.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: const Text("Olá, João"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(children: [
        Stack(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20.5, right: 20.5, left: 20.5),
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              height: 230,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 30.5, left: 20),
              child: GlobalCustomElevatedButton(
                color: Colors.pretoPag,
                height: 220,
                width: double.infinity,
                onPressed: () {},
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CustomText(
                            text: 'Situação:',
                            fontSize: 18,
                            isBold: true,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: 'Concluido',
                            fontSize: 20,
                            isBold: true,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomText(
                          text: '${dateFormat(now)}',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GlobalCustomElevatedButton(
                      height: 80,
                      width: 150,
                      onPressed: () {
                        Navigator.pushNamed(context, '/trainingList');
                      },
                      child: const CustomText(
                        text: 'Treinos',
                        isBold: true,
                        fontSize: 20,
                      ),
                    ),
                    GlobalCustomElevatedButton(
                      height: 80,
                      width: 150,
                      onPressed: () {
                        Navigator.pushNamed(context, '/graphics');
                      },
                      child: const CustomText(
                        text: 'Gráficos',
                        isBold: true,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GlobalCustomElevatedButton(
                      height: 80,
                      width: 150,
                      onPressed: () {
                        Navigator.pushNamed(context, '/measures');
                      },
                      child: const CustomText(
                        text: 'Medidas',
                        isBold: true,
                        fontSize: 20,
                      ),
                    ),
                    GlobalCustomElevatedButton(
                      height: 80,
                      width: 150,
                      onPressed: () {},
                      child: const CustomText(
                        text: 'Ranking',
                        isBold: true,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
