import 'package:app_delivery_ponto_do_pastel/components/myDrawer.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                // print('Clique profile navbar');
                {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 241, 241, 241),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_outline, size: 60),
                    Expanded(
                      child: Text(
                        "OLÁ, NOME DO USUÁRIO!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Meus dados'),
              onTap: () {
                Navigator.pushNamed(context, '/perfil-menu/meus-dados');
              },
              trailing: const Icon(
                Icons.navigate_next_outlined,
                size: 40,
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Precisa de ajuda?'),
              onTap: () {
                Navigator.pushNamed(context, '/perfil-menu/ajuda');
              },
              trailing: const Icon(
                Icons.navigate_next_outlined,
                size: 40,
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              trailing: const Icon(
                Icons.navigate_next_outlined,
                size: 40,
              ),
            ),
            const Divider(),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          })
        },
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Cardápio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
        ],
      ),
    );
  }
}
