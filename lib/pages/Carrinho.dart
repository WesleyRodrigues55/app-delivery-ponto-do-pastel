import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:app_delivery_ponto_do_pastel/components/myDrawer.dart';
import 'package:app_delivery_ponto_do_pastel/pages/FormaPagamento.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Pagamento.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

List<String> list = ['-', 'PIX'];

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  int _currentIndex = 0;
  String dropdownValue = list.first;
  final controllerRua = TextEditingController();
  final controllerNumero = TextEditingController();
  final controllerBairro = TextEditingController();
  final controllerReferencia = TextEditingController();

  void validarBotao() {
    if (dropdownValue == '-') {
      SnackBarUtils.showSnackBar(
          context, 'Por favor, selecione um método de pagamento!');
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Pagamento()));
    }
  }

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
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
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Form(
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
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            )
                          },
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
                          Text('Taxa de Entrega',
                              style: TextStyle(fontSize: 14)),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Endereço de Entrega',
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
                      Form(
                          child: Column(children: [
                        InputCustom(
                          controllerName: controllerRua,
                          label: 'Rua',
                          placeholder: 'Rua',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputCustom(
                          controllerName: controllerNumero,
                          label: 'Número',
                          placeholder: 'Número',
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputCustom(
                          controllerName: controllerBairro,
                          label: 'Bairro',
                          placeholder: 'Bairro',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputCustom(
                          controllerName: controllerReferencia,
                          label: 'Referência',
                          placeholder: 'Referência',
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ])),
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
                            'Escolha a Forma de Pagamento:',
                            style: TextStyle(fontSize: 14),
                          ),
                          DropdownButton(
                            value: dropdownValue,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 1,
                              color: Colors.red,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                          )
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
                    onPressed: () => {validarBotao()},
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
