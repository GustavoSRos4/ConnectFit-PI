import 'package:flutter/material.dart';
import 'package:projeto/Pages/CreateAcc/Steps/three_infos.dart';
import 'package:projeto/Shared/Widgets/custom_app_bar.dart';
import 'package:projeto/Pages/CreateAcc/Steps/two_dados.dart';
import 'package:projeto/Pages/CreateAcc/Steps/one_login.dart';

class Register1 extends StatefulWidget {
  const Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  var navKey = GlobalKey<NavigatorState>();

  void _sairCadastro() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPopNavRegister = navKey.currentState?.canPop() ?? false;
        if (canPopNavRegister) {
          navKey.currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.begeclaro,
        appBar: CustomAppBar(
          height: 100,
          title: const Text('Cadastro'),
          actions: [
            IconButton(
              onPressed: _sairCadastro,
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: Navigator(
          initialRoute: '/oneLogin',
          key: navKey,
          onGenerateRoute: (settings) {
            var route = settings.name;
            Widget page;
            switch (route) {
              case '/oneLogin':
                page = const OneLogin();
                break;
              case '/twoDados':
                page = const TwoDados();
                break;
              case '/threeInfos':
                page = const ThreeInfos();
                break;

              default:
                return null;
            }
            return MaterialPageRoute(
              builder: (context) => page,
              settings: settings,
            );
          },
        ),
      ),
    );
  }
}
