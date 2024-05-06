import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
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
                print('Clique profile navbar');
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => {
            setState(() {
              _currentIndex = index;
              if (index == 2) {
              Navigator.pushNamed(context, '/carrinho');              
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Text(
                            '1x',
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text('Pastel de Chocolate'),
                          subtitle: Text('R\$ 10,00'),
                          trailing: Image.network(
                              'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg'),
                        ),
                        Divider(
                          height: 0,
                          color: Color.fromARGB(255, 199, 197, 197),
                        ),
                        ListTile(
                          leading: Text(
                            '1x',
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text('Pastel de Chocolate'),
                          subtitle: Text('R\$ 10,00'),
                          trailing: Image.network(
                              'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg'),
                        ),
                        Divider(
                          height: 0,
                          color: Color.fromARGB(255, 199, 197, 197),
                        ),
                        ListTile(
                          leading: Text(
                            '1x',
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text('Pastel de Chocolate'),
                          subtitle: Text('R\$ 10,00'),
                          trailing: Image.network(
                              'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg'),
                        ),
                        Divider(
                          height: 0,
                          color: Color.fromARGB(255, 199, 197, 197),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      PrimaryButton(
                        title: "+ Continuar Comprando",
                        extraLarge: 0,
                        onPressed: () => {Navigator.pushNamed(context, '/')},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Color.fromARGB(255, 231, 231, 231),
              child: const Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: TextStyle(fontSize: 14)),
                        Text('R\$ 10.00', style: TextStyle(fontSize: 14))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Taxa de Entrega', style: TextStyle(fontSize: 14)),
                        Text('R\$ 6,00', style: TextStyle(fontSize: 14))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('TOTAL',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Text('R\$ 16,00',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'O pedido mínimo desse restaurante para entrega é de R\$ 10,00, sem contar a taxa de entrega',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Pagamento',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pagamento',
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () => {Navigator.pushNamed(context, '/forma-pagamento')},
                          child: Text(
                            'Escolher',
                            style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                PrimaryButton(
                  title: "Finalizar Pedido",
                  extraLarge: 0,
                  textColor: Colors.black,
                  bgButton: Color.fromARGB(255, 199, 197, 197),
                  onPressed: () => {Navigator.pushNamed(context, '/pagamento')},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
