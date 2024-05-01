import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => {},
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Text(
                          '1x',
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text('Pastel de Chocolate'),
                        subtitle: Text('RS: 10,00'),
                        trailing: Image.network(
                            'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg'),
                      ),
                      Divider(
                        height: 0,
                      ),
                      ListTile(
                        leading: Text(
                          '1x',
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text('Pastel de Chocolate'),
                        subtitle: Text('RS: 10,00'),
                        trailing: Image.network(
                            'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg'),
                      ),
                      Divider(
                        height: 0,
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
