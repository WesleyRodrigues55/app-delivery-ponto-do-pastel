import 'package:flutter/material.dart';

class MyData extends StatefulWidget {
  const MyData({super.key});

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  int _currentIndex = 0;
  bool _isMeusDadosExpanded = false;
  bool _isAlterarDadosExpanded = false;
  void _handleMeusDadosExpansion(bool isExpanded) {
    setState(() {
      _isMeusDadosExpanded = isExpanded;
      if (isExpanded && _isAlterarDadosExpanded) {
        _isAlterarDadosExpanded = false;
      }
    });
  }

  void _handleAlterarDadosExpansion(bool isExpanded) {
    setState(() {
      _isAlterarDadosExpanded = isExpanded;
      if (isExpanded && _isMeusDadosExpanded) {
        _isMeusDadosExpanded = false;
      }
    });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: ExpansionTile(
                initiallyExpanded: _isMeusDadosExpanded,
                onExpansionChanged: _handleMeusDadosExpansion,
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
            const Divider(),
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: ExpansionTile(
                initiallyExpanded: false,
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
                    child: const Column(
                      children: [
                        Divider(),
                        ListTile(
                          title: Text('Novo Endereço'),
                          trailing: Text(
                            "_________________",
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
