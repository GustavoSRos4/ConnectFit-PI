import 'package:flutter/material.dart';
import 'package:projeto/Pages/HomePage/home_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void _teste() {
    debugPrint("Deu certo BUSCA");
  }

  void _teste2() {
    debugPrint("Deu certo NOTIFICAÇÃO");
  }

  void _onIndexChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text("Aplicativo"),
        actions: [
          IconButton(
            onPressed: _teste,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: _teste2,
          ),
        ],
      ),
      body: const HomePage(),
      bottomNavigationBar: BottomNavBar(
        onIndexChanged: _onIndexChanged,
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.deepOrange,
      elevation: 30,
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("João Vitor"),
            accountEmail: Text("Teste@Gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://loremflickr.com/320/240',
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.blue,
            leading: const Icon(
              Icons.not_interested_sharp,
            ),
            title: const Text("Primeira Opção"),
            subtitle: const Text("Detalhes da primeira opção"),
            onTap: () => {
              debugPrint("Apertou Primeira Opção"),
            },
          ),
          const SizedBox(
            height: 1,
          ),
          ListTile(
            tileColor: Colors.green,
            leading: const Icon(
              Icons.add_to_photos,
            ),
            title: const Text("Segunda Opção"),
            subtitle: const Text("Detalhes da Segunda opção"),
            onTap: () => {
              debugPrint("Apertou Segunda Opção"),
            },
          ),
          const SizedBox(
            height: 1,
          ),
          ListTile(
            tileColor: Colors.purple,
            leading: const Icon(
              Icons.military_tech,
            ),
            title: const Text("Terceira Opção"),
            subtitle: const Text("Detalhes da Terceira opção"),
            onTap: () => {
              debugPrint("Apertou Terceira Opção"),
            },
          ),
        ],
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
      debugPrint("$_currentIndex");
      widget.onIndexChanged(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      backgroundColor: Colors.deepOrange,
      currentIndex: _currentIndex,
      onTap: (index) {
        setIndex(index);
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/trainingList');
            break;
          case 2:
            Navigator.pushNamed(context, '/perfil');
            break;
          default:
            return;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Início",
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/iconePeso.png'),
          ),
          label: "Treino",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box),
          label: "Perfil",
        )
      ],
    );
  }
}
