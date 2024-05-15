import 'dart:convert';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/components/myDrawer.dart';
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
  bool status = true;

  @override
  void initState() {
    super.initState();
    verificarStatusLoja().then((value) {
      if (value) {
        setState(() {
          status = true;
        });
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      verificaStatus();
    }
  }

  void verificaStatus() {
    verificarStatusLoja().then((value) {
      if (value) {
        setState(() {
          status = true;
        });
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  Future<bool> verificarStatusLoja() async {
    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/store/get-status');
    var response = await http.get(url);
    var data = json.decode(response.body);

    var status = data['results'][0]['status'];

    if (status == 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status) {
      return DefaultTabControllerHome(context);
    } else {
      return lojaFechada(context);
    }
  }

  Scaffold lojaFechada(BuildContext context) {
    return Scaffold(
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
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.red,
                    maxRadius: 100,
                    child: Icon(
                      Icons.close_sharp,
                      size: 140,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  const Text('QUE PENA!'),
                  const Text(
                    "A LOJA ESTÁ FECHADA!",
                    style: TextStyle(fontSize: 28),
                  ),
                  const Text('Volte mais tarde...'),
                  PrimaryButton(
                      title: 'Recaregar Página',
                      extraLarge: 0,
                      bgButton: Colors.red,
                      onPressed: verificaStatus)
                ],
              ),
              Container(
                color: Colors.red,
                alignment: Alignment.center,
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Nosso horário de funcionamento é das 18h às 23h.',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DefaultTabController DefaultTabControllerHome(BuildContext context) {
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
        drawer: const MyDrawer(),
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
