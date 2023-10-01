import 'package:flutter/material.dart';
import 'package:projeto/Pages/Shared/Models/login_model.dart';
import 'package:projeto/Pages/Shared/Widgets/custom_text_field.dart';
import 'package:string_validator/string_validator.dart';

class ThreePage extends StatefulWidget {
  final ValueNotifier<VoidCallback?> floatingButtonAction;
  const ThreePage({super.key, required this.floatingButtonAction});

  @override
  State<ThreePage> createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
  final usuarioEC = TextEditingController();
  final emailEC = TextEditingController();
  final senhaEC = TextEditingController();
  final confirmarSenhaEC = TextEditingController();
  late LoginModel loginModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loginModel = ModalRoute.of(context)?.settings.arguments as LoginModel;
    });

    widget.floatingButtonAction.value = () {
      debugPrint("eita deu certo zé 3");
      var model = loginModel.copyWith(
        usuario: usuarioEC.text,
        email: emailEC.text,
        senha: senhaEC.text,
      );
      debugPrint(model.toString());
    };
  }

  @override
  void dispose() {
    super.dispose();
    usuarioEC.dispose();
    emailEC.dispose();
    senhaEC.dispose();
    confirmarSenhaEC.dispose();
  }

  var passwordCache = '';
  var passwordCacheConfirm = '';
  bool obscureTextPassword = true;
  bool obscureTextPasswordConfirm = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CustomTextField(
                  label: "Usuário",
                  icon: Icons.person,
                  hint: "Digite seu usuário...",
                  controller: usuarioEC,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Esse campo não pode ficar vazio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
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
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Senha",
                  hint: "Digite sua senha...",
                  icon: Icons.vpn_key,
                  obscureTest: obscureTextPassword,
                  controller: senhaEC,
                  sufix: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureTextPassword = !obscureTextPassword;
                      });
                    },
                    icon: Icon(
                      obscureTextPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Esse campo não pode ficar vazio";
                    }
                    return null;
                  },
                  onChanged: (text) => passwordCache = text,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  label: "Confirmar Senha",
                  hint: "Confirme sua senha...",
                  icon: Icons.vpn_key,
                  obscureTest: obscureTextPasswordConfirm,
                  controller: confirmarSenhaEC,
                  onChanged: (text) => passwordCacheConfirm = text,
                  sufix: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureTextPasswordConfirm =
                            !obscureTextPasswordConfirm;
                      });
                    },
                    icon: Icon(obscureTextPasswordConfirm
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Esse campo não pode ficar vazio";
                    }
                    if (passwordCacheConfirm != passwordCache) {
                      return "As senhas não estão iguais!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
