import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/text_white.dart';
import 'package:projeto/Shared/Blocs/date_format.dart';

class FormDetails extends StatefulWidget {
  const FormDetails({super.key});

  @override
  State<FormDetails> createState() => _FormDetailsState();
}

class _FormDetailsState extends State<FormDetails> {
  late int index;
  DateTime agora = DateTime.now();
  final List<Item> _data = generateItems(5);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        index = ModalRoute.of(context)?.settings.arguments as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Esta é a ficha $index'),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 40,
          left: 40,
          top: 15,
          bottom: 15,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWhite(
                  text: '${dateFormat(agora)}',
                  fontSize: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.date_range,
                    size: 35,
                  ),
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  child: _buildPanel(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: const EdgeInsets.all(0),
      children: _data.map<ExpansionPanelRadio>((Item item) {
        return ExpansionPanelRadio(
          value: item.id,
          canTapOnHeader: true,
          backgroundColor: Colors.deepOrange,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title:
                  TextWhite(isBold: true, text: item.headerValue, fontSize: 17),
            );
          },
          body: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.bege,
                  height: 100,
                  child: const Center(
                    child: Text('VIDEO'),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Existem muitas variações das passagens do Lorem Ipsum disponíveis, mas a maior parte sofreu alterações de alguma forma, pela injecção de humor, ou de palavras aleatórias que nem sequer parecem suficientemente credíveis.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const TextWhite(text: 'Repetições: ', isBold: true),
                const TextWhite(text: 'Descanso: ', isBold: true),
                const TextWhite(text: 'Carga: ', isBold: true),
                const TextWhite(text: 'Inicio: ', isBold: true),
                const TextWhite(text: 'Fim: ', isBold: true),
                const TextWhite(text: 'Tempo Gasto: ', isBold: true),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pretoPag,
                      ),
                      onPressed: () {},
                      child: const TextWhite(
                        text: 'Iniciar',
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pretoPag,
                      ),
                      onPressed: () {},
                      child: const TextWhite(
                        text: 'Finalizar',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
  });

  int id;
  String expandedValue;
  String headerValue;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      id: index,
      headerValue: 'Treino $index',
      expandedValue: 'Este é o treino $index',
    );
  });
}
