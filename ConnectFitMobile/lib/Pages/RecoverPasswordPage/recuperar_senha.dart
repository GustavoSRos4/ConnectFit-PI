import 'package:flutter/material.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Shared/Widgets/custom_text.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:projeto/Shared/Widgets/global_custom_elevated_button.dart';
import 'package:string_validator/string_validator.dart';

class RecuperarSenha extends StatelessWidget {
  const RecuperarSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: Text('Recuperar Senha'),
        actions: [],
      ),
      body: BodyPasswordRecorvery(),
    );
  }
}

class BodyPasswordRecorvery extends StatefulWidget {
  const BodyPasswordRecorvery({super.key});

  @override
  State<BodyPasswordRecorvery> createState() => _BodyPasswordRecorveryState();
}

class _BodyPasswordRecorveryState extends State<BodyPasswordRecorvery> {
  final emailEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                scale: 2,
                'assets/images/cadeado.png',
                color: Colors.deepOrange,
              ),
              const SizedBox(
                height: 40,
              ),
              const CustomText(
                text: 'Problemas para fazer login?',
                isBold: true,
                fontSize: 18,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(right: 40, left: 40),
                child: const CustomText(
                  text:
                      'Digite seu e-mail e enviaremos um link para redefinir sua senha.',
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(right: 40, left: 40),
                child: CustomTextField(
                  label: "E-mail",
                  icon: Icons.mail,
                  hint: "Digite seu e-mail...",
                  controller: emailEC,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Esse campo não pode ficar vazio";
                    }
                    if (!isEmail(text)) {
                      return "Esse não é um e-mail válido!";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(right: 40, left: 40),
                child: GlobalCustomElevatedButton(
                  height: 60,
                  borderRadius: 50,
                  width: double.infinity,
                  onPressed: () {},
                  child: const CustomText(
                    text: 'Enviar Link',
                    fontSize: 20,
                    isBold: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
