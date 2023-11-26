import 'package:flutter/material.dart';
import 'package:projeto/Pages/ContratoPage/page_contrato.dart';
import 'package:projeto/Pages/HomePage/home_page.dart';
import 'package:projeto/Pages/PerfilPage/perfil.dart';
import 'package:projeto/Pages/PersonalPage/personal_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final _pageOptions = [
    const HomePage(),
    const PersonalPage(),
    const PageContrato(),
    const PerfilPage(),
  ];
  void _onIndexChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[currentIndex],
      bottomNavigationBar: BottomNavBar(
        onIndexChanged: _onIndexChanged,
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int> onIndexChanged;

  const BottomNavBar({Key? key, required this.onIndexChanged})
      : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _currentIndex = 0;

  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
      widget.onIndexChanged(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.deepOrange, // Adicione esta linha
        showUnselectedLabels: false,
        selectedItemColor: Colors.brancoBege,
        unselectedItemColor: Colors.pretoPag,
        currentIndex: _currentIndex,
        onTap: setIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Personal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_travel),
            label: "Contratos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Perfil",
          )
        ],
      ),
    );
  }
}
