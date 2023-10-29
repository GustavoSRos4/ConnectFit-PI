import 'package:flutter/material.dart';

//Widget usado na parte dos detalhes dos treinos,
//por padrão ele vem com um tamanho normal, se especificar (twoButtons = true)
//Vai trocar o botão normal para dois botões ocupando o mesmo espaço.

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
