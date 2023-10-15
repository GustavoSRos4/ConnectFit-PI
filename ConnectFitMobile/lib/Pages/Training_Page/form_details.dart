import 'dart:async';

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
  DateTime now = DateTime.now();
  final List<Item> _data = generateItems(5);

  int miliseconds = 0;
  bool timerStarted = false;
  bool timerPaused = false;
  late Timer timer;

  void startTimer() {
    if (!timerStarted) {
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        miliseconds += 100;
        setState(() {});
      });
      timerStarted = !timerStarted;
    } else if (timerPaused) {
      timerPaused = !timerPaused;
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        miliseconds += 100;
        setState(() {});
      });
    }
  }

  void resetTimer() {
    timer.cancel();
    miliseconds = 0;
    timerStarted = false;
    timerPaused = false;
    setState(() {});
  }

  void pauseTimer() {
    timer.cancel();
    setState(() {});
    timerPaused = !timerPaused;
  }

  String formatTime() {
    Duration duration = Duration(milliseconds: miliseconds);

    String twoDigits(int valor) {
      return valor >= 10 ? "$valor" : "0$valor";
    }

    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    String milliseconds = twoDigits(duration.inMilliseconds.remainder(1000));

    return "$hours:$minutes:$seconds:$milliseconds";
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
                  text: '${dateFormat(now)}',
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
                Row(
                  children: [
                    const TextWhite(text: 'Tempo Gasto:', isBold: true),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWhite(text: formatTime()),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    timerStarted
                        ? Row(
                            children: [
                              timerPaused
                                  ? CustomElevatedButton(
                                      twoButtons: true,
                                      onPressed: () {
                                        startTimer();
                                      },
                                      child: const Icon(Icons.play_arrow),
                                    )
                                  : CustomElevatedButton(
                                      twoButtons: true,
                                      onPressed: () {
                                        pauseTimer();
                                      },
                                      child: const Icon(Icons.pause),
                                    ),
                              const SizedBox(
                                width: 2,
                              ),
                              CustomElevatedButton(
                                twoButtons: true,
                                onPressed: () {
                                  resetTimer();
                                },
                                child: const Icon(Icons.stop),
                              ),
                            ],
                          )
                        : CustomElevatedButton(
                            onPressed: () {
                              startTimer();
                            },
                            child: const TextWhite(
                              text: 'Iniciar',
                            ),
                          ),
                    CustomElevatedButton(
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

class CustomElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final bool twoButtons;
  final Widget child;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.twoButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: twoButtons ? 60 : 122,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pretoPag,
            ),
            onPressed: onPressed,
            child: child),
      ),
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
