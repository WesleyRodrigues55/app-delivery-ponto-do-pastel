import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';

class MyData extends StatefulWidget {
  const MyData({super.key});

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  int _currentIndex = 0;
  int _expandedPanelIndex = -1;

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
                Navigator.pop(context);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 33.0),
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _expandedPanelIndex = isExpanded ? -1 : panelIndex;
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: const Text(
                        'MEUS DADOS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Container(
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
                  isExpanded: _expandedPanelIndex == 0,
                ),
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: const Text(
                        'ALTERAR DADOS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Divider(),
                        ListTile(
                          subtitle: Column(
                            children: [
                              //ARRUMAR
                              InputCustom(
                                label: 'Novo endereço *',
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
                  isExpanded: _expandedPanelIndex == 1,
                ),
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: const Text(
                        'ALTERAR SENHA',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Divider(),
                        ListTile(
                          subtitle: Column(
                            children: [
                              //ARRUMAR
                              InputCustom(
                                label: 'Senha atual *',
                                placeholder: '***************',
                                controllerName: TextEditingController(),
                                validation: (value) {},
                              ),
                              //ARRUMAR
                              InputCustom(
                                label: 'Nova senha *',
                                placeholder: '***************',
                                controllerName: TextEditingController(),
                                validation: (value) {},
                              ),
                              //ARRUMAR
                              InputCustom(
                                label: 'Repita a nova senha *',
                                placeholder: '***************',
                                controllerName: TextEditingController(),
                                validation: (value) {},
                              ),
                              const SizedBox(height: 33.0),
                              //ARRUMAR
                              PrimaryButton(
                                onPressed: () {},
                                title: 'Alterar Senha',
                                extraLarge: 1,
                              ),
                              const SizedBox(height: 33.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  isExpanded: _expandedPanelIndex == 2,
                ),
              ],
            ),
            SizedBox(height: 33.0),
          ],
        ),
      ),
      drawer: const Drawer(),
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
