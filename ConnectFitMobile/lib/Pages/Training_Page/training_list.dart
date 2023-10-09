import 'package:flutter/material.dart';

class TrainingList extends StatelessWidget {
  const TrainingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text("Fichas de treino"),
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
              itemCount: 50,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40),
                  child: Card(
                    color: Colors.deepOrange,
                    child: ListTile(
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
