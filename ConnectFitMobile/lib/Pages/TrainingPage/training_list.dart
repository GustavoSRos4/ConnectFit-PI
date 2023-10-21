import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';

class TrainingList extends StatefulWidget {
  const TrainingList({super.key});

  @override
  State<TrainingList> createState() => _TrainingListState();
}

class _TrainingListState extends State<TrainingList> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Fichas de treino'),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Flexible(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  right: 40,
                  left: 45,
                  top: 15,
                  bottom: 15,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: SizedBox(
                        height: 25,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            filled: true,
                            fillColor: Colors.brancoBege,
                            labelText: 'Buscar',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt),
                      color: Colors.brancoBege,
                      iconSize: 30,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.pretoPag,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              color: Colors.white38,
                              width: 2,
                            ),
                          ),
                          margin: const EdgeInsetsDirectional.only(
                            start: 30,
                            end: 30,
                          ),
                          child: ExpansionTile(
                            collapsedIconColor: Colors.white,
                            iconColor: Colors.white,
                            title: const CustomText(
                              text: "Teste",
                              isBold: true,
                            ),
                            children: <Widget>[
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 40, left: 40),
                                    child: Card(
                                      color: Colors.deepOrange,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/formDetails',
                                              arguments: (index + 1));
                                        },
                                        textColor: Colors.white,
                                        title: Text(textos[index]),
                                        subtitle: Text(
                                            'Detalhes do ${textos[index]}'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              GestureDetector(
                onTap: _toggleExpand,
                child: Container(
                  color: Colors.blue,
                  width: 200,
                  height: 50,
                  child: const Center(
                    child: Text(
                      'Clique para Expandir',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                height: _isExpanded ? null : 0,
                color: Colors.green,
                child: const Center(
                  child: Column(
                    children: [
                      Text(
                        'Conteúdo Expandido',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> textos = [
  "Treino A",
  "Treino B",
  "Treino C",
  "Treino D",
  "Treino E",
];
