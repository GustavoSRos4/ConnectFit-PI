import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';

class TrainingList extends StatelessWidget {
  const TrainingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Fichas de treino'),
        actions: [],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 40,
              left: 40,
              top: 15,
              bottom: 15,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      filled: true,
                      fillColor: Colors.brancoBege,
                      labelText: 'Buscar',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_alt),
                  color: Colors.brancoBege,
                  iconSize: 50,
                )
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40),
                  child: Card(
                    color: Colors.deepOrange,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/formDetails',
                            arguments: (index + 1));
                      },
                      textColor: Colors.white,
                      title: Text('Ficha ${index + 1}'),
                      subtitle: Text('Detalhes da ficha ${index + 1}'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
