import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/Shared/Widgets/custom_text_field.dart';
import 'package:string_validator/string_validator.dart';
import 'package:get/get.dart';

class NewAccount extends StatefulWidget {
  const NewAccount({super.key});

  @override
  State<NewAccount> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dados pessoais"),
        backgroundColor: Colors.deepOrange,
      ),
      body: const SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: BodyNewAcc(),
          ),
        ),
      ),
    );
  }
}

class BodyNewAcc extends StatefulWidget {
  const BodyNewAcc({super.key});

  @override
  State<BodyNewAcc> createState() => _BodyNewAccState();
}

class _BodyNewAccState extends State<BodyNewAcc> {
  final controller = TextEditingController();
  var user = const UserModel();
  var passwordCache = '';
  var passwordCacheConfirm = '';
  bool obscureTextPassword = true;
  bool obscureTextPasswordConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: "Nome",
          icon: Icons.person,
          hint: "Digite seu nome...",
          onSaved: (text) => user = user.copyWith(nome: text),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Esse campo não pode ficar vazio";
            }
            if (text.length < 5) {
              return "Esse campo precisa de mais de 5 letras. (Tem ${text.length})";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        CustomTextField(
          label: "CPF",
          icon: Icons.credit_card,
          hint: "Digite seu CPF...",
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CpfInputFormatter(),
          ],
          onSaved: (text) => user = user.copyWith(cpf: text),
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Esse campo não pode ficar vazio";
            }
            if (!GetUtils.isCpf(text)) {
              return "CPF invalido";
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        CustomTextField(
          label: "E-mail",
          icon: Icons.mail,
          hint: "Digite seu e-mail...",
          onSaved: (text) => user = user.copyWith(email: text),
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
        const SizedBox(
          height: 15,
        ),
        CustomTextField(
          label: "Senha",
          hint: "Digite sua senha...",
          icon: Icons.vpn_key,
          obscureTest: obscureTextPassword,
          onSaved: (text) => user = user.copyWith(password: text),
          sufix: IconButton(
            onPressed: () {
              setState(() {
                obscureTextPassword = !obscureTextPassword;
              });
            },
            icon: Icon(
              obscureTextPassword ? Icons.visibility : Icons.visibility_off,
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
        const SizedBox(
          height: 15,
        ),
        CustomTextField(
          label: "Confirmar Senha",
          hint: "Confirme sua senha...",
          icon: Icons.vpn_key,
          obscureTest: obscureTextPasswordConfirm,
          onSaved: (text) => user = user.copyWith(password: text),
          onChanged: (text) => passwordCacheConfirm = text,
          sufix: IconButton(
            onPressed: () {
              setState(() {
                obscureTextPasswordConfirm = !obscureTextPasswordConfirm;
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
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              if (Form.of(context).validate()) {
                Form.of(context).save();
                debugPrint(""" Testando 
                
                Nome: ${user.nome}
                CPF: ${user.cpf}
                Email: ${user.email}
                Password: ${user.password}
                """);
              }
            },
            icon: const Icon(Icons.save),
            label: const Text(
              "Salvar",
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              Form.of(context).reset();
            },
            icon: const Icon(Icons.save),
            label: const Text(
              "Limpar",
            ),
          ),
        ),
      ],
    );
  }
}

@immutable
class UserModel {
  final String nome;
  final String cpf;
  final String email;
  final String password;

  const UserModel({
    this.nome = "",
    this.cpf = "",
    this.email = "",
    this.password = "",
  });

  UserModel copyWith({
    String? nome,
    String? cpf,
    String? email,
    String? password,
  }) {
    return UserModel(
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class DatePickerButton extends StatefulWidget {
  const DatePickerButton({super.key});

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Selecionar Data'),
        ),
        const SizedBox(height: 20.0),
        Text(
          'Data Selecionada: ${selectedDate!.toLocal()}'.split(' ')[0],
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
