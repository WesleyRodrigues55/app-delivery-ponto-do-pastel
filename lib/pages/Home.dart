import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:app_delivery_ponto_do_pastel/components/cardapio.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                  print('Clique profile navbar');
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
      onTap: () {
        print('Finalizar sessão');
      },
    );
  }
}
