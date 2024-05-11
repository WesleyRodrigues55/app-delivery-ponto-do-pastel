import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/components/myDrawer.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';

class MyData extends StatefulWidget {
  const MyData({super.key});

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  int _currentIndex = 0;
  bool _isMeusDadosExpanded = true;
  bool _isAlterarDadosExpanded = false;
  int _expandedTileIndex = 0;
  final formKey = GlobalKey<FormState>();

  void _handleExpansion(int tileIndex) {
    setState(() {
      if (_expandedTileIndex == tileIndex) {
        // Se o mesmo ExpansionTile estiver sendo expandido novamente, feche-o
        _expandedTileIndex = -1;
      } else {
        _expandedTileIndex = tileIndex;
      }
    });
  }

  void validaCampoAlterarDados() {
    if (formKey.currentState!.validate()) {
      SnackBarUtils.showSnackBar(context, 'Formulário enviado');
    } else {
      SnackBarUtils.showSnackBar(context, 'Os campos precisam ser preenchidos');
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
        child: Form(
          // key: FormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: const Color.fromARGB(255, 241, 241, 241),
                child: ExpansionTile(
                  initiallyExpanded: _expandedTileIndex == 0,
                  onExpansionChanged: (isExpanded) {
                    _handleExpansion(0);
                  },
                  title: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "MEUS DADOS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [
                    Container(
                      color: Colors.white,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text('Nome'),
                            trailing: Text(
                              "Lucas Suzuki",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('CPF'),
                            trailing: Text(
                              "000.000.000-00",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Data Nascimento'),
                            trailing: Text(
                              "15/01/2000",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('E-mail'),
                            trailing: Text(
                              "lucassuzuki@gmail.com",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('WhatsApp'),
                            trailing: Text(
                              "(15)99999-9999",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Endereço'),
                            trailing: Text(
                              "Rua Flutter",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 33.0),
              Container(
                color: const Color.fromARGB(255, 241, 241, 241),
                child: ExpansionTile(
                  onExpansionChanged: (isExpanded) {
                    _handleExpansion(1);
                  },
                  initiallyExpanded: _expandedTileIndex == 1,
                  title: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "ALTERAR DADOS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const Divider(),
                          ListTile(
                            subtitle: Column(
                              children: [
                                //ARRUMAR
                                InputCustom(
                                  label: 'Novo endereço *',
                                  keyboardType: TextInputType.streetAddress,
                                  placeholder: 'Digite o novo endereço',
                                  controllerName: TextEditingController(),
                                  validation: (value) {},
                                ),
                                const SizedBox(height: 33.0),
                                //ARRUMAR
                                PrimaryButton(
                                  onPressed: () {},
                                  title: 'Alterar Endereço',
                                  extraLarge: 1,
                                ),
                                const SizedBox(height: 33.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 33.0),
            ],
          ),
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
