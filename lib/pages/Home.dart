import 'dart:convert';
import 'package:app_delivery_ponto_do_pastel/pages/BoasVindas.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Carrinho.dart';
import 'package:app_delivery_ponto_do_pastel/pages/MyData.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Pedidos.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:app_delivery_ponto_do_pastel/components/cardapio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 231, 231, 231),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyData(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          bottom: const TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              tabs: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Salgados'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Doces'),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Bebidas'),
                ),
              ]),
        ),
        body: const TabBarView(
          children: [
            Cardapio(category: 'salgados'),
            Cardapio(category: 'doces'),
            Cardapio(category: 'bebidas'),
          ],
        ),
        drawer: const Drawer(
          backgroundColor: Color.fromARGB(255, 231, 231, 231),
          child: Padding(
            padding: EdgeInsets.only(top: 20, right: 0, left: 20),
            child: Column(
              children: [logoutDrawer(), itemsDrawer()],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => {
            setState(() {
              _currentIndex = index;
              if (index == 2) {
                // Navigator.pushNamed(context, '/carrinho');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Carrinho()),
                );
              }
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pedidos()),
                );
              }
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              }
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
      ),
    );
  }
}

class itemsDrawer extends StatelessWidget {
  const itemsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 60),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Meu Perfil'),
              onTap: () {
                print('Meu Perfil');
              },
            ),
            ListTile(
              title: const Text('Fale Conosco'),
              onTap: () {
                print('Fale Conosco');
              },
            ),
            ListTile(
              title: const Text('Dúvidas Frequentes'),
              onTap: () {
                print('Dúvidas Frequentes');
              },
            ),
          ],
        ));
  }
}

class logoutDrawer extends StatelessWidget {
  const logoutDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Finalizar sessão',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.logout,
            color: Colors.black,
          )
        ],
      ),
      onTap: () async {
        bool isLogout = await logout();
        if (isLogout) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BoasVindas()),
          );
        }
      },
    );
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
