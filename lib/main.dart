import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ponto do pastel',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 198, 6, 6)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'LOGO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  String _selectedCategory  = "SALGADOS";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){print('Clique profile navbar');}, 
              icon: const Icon(Icons.person, color: Colors.black,),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: double.infinity,
          color: const Color.fromARGB(255, 241, 241, 241),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            _selectedCategory = "SALGADOS";
                          })
                        },
                        child: Text(
                          'SALGADOS',
                          style: TextStyle(
                            color: _selectedCategory == "SALGADOS" ? Color.fromARGB(255, 198, 6, 6) : Colors.black,
                  
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            _selectedCategory = "DOCES";
                          })
                        },
                        child: Text(
                          'DOCES',
                          style: TextStyle(
                            color: _selectedCategory == "DOCES" ? Color.fromARGB(255, 198, 6, 6) : Colors.black,
                  
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            _selectedCategory = "BEBIDAS";
                          })
                        },
                        child: Text(
                          'BEBIDAS',
                          style: TextStyle(
                            color: _selectedCategory == "BEBIDAS" ? Color.fromARGB(255, 198, 6, 6) : Colors.black,
                  
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                    ],
                  ),
                ),
              ),
            
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  PrimaryButton(title: 'Login', extraLarge: 1),
                ],
              ),
            ),
            ],
          ),
        ), 
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 0, left: 20),
          child: Column(
            children: [
              ListTile(
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Finalizar sessão',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(width: 20,),
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    )
                  ],
                ), 
                onTap: (){print('Finalizar sessão');},
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Meu Perfil'), 
                      onTap: (){print('Meu Perfil');},
                    ),
                    ListTile(
                      title: Text('Fale Conosco'), 
                      onTap: (){print('Fale Conosco');},
                    ),
                    ListTile(
                      title: Text('Dúvidas Frequentes'), 
                      onTap: (){print('Dúvidas Frequentes');},
                    ),
                  ],
                )
              )
              
            ],
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
        backgroundColor: Color.fromARGB(255, 251, 251, 251),
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


