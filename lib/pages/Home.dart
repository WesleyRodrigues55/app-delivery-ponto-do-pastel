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
  String _selectedCategory = "SALGADOS";

  List<Map<dynamic, dynamic>> salgados = [
    {
      'nomeProduto': 'Pastel de Carne',
      'descricaoProduto':
          'Delicioso paste de carne moída temperadinha com azeitonas e ovo',
      'precoProduto': 'Pastel Carne',
      'imageProduto': '/img/produtos/pastel-carne.png',
    },
    {
      'nomeProduto': 'Pastel de Queijo',
      'descricaoProduto':
          'Delicioso pastel recheado com muuuito queijo mussarela',
      'precoProduto': 'Pastel Carne',
      'imageProduto': '/img/produtos/pastel-queijo.png',
    },
    {
      'nomeProduto': 'Pastel de Brócolis',
      'descricaoProduto':
          'Para os vegetarianos de plantão! Delicioso pastel de brócolis temperadinho',
      'precoProduto': 'Pastel Carne',
      'imageProduto': '/img/produtos/pastel-brocolis.png',
    }
  ];

  List<Map<dynamic, dynamic>> doces = [
    {
      'nomeProduto': 'Pastel Chocolate',
      'descricaoProduto': 'Pastel de nutella',
      'precoProduto': 'Pastel Carne',
      'imageProduto':
          'https://live.staticflickr.com/5007/5289570176_d4002b4fa6_w.jpg',
    },
    {
      'nomeProduto': 'Pastel Romeu e Julieta',
      'descricaoProduto': 'Pastel Carne recheado',
      'precoProduto': 'Pastel Carne',
      'imageProduto':
          'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg',
    }
  ];

  List<Map<dynamic, dynamic>> bebidas = [
    {
      'nomeProduto': 'Coca Cola',
      'descricaoProduto': 'Pastel de nutella',
      'precoProduto': 'Pastel Carne',
      'imageProduto':
          'https://live.staticflickr.com/5007/5289570176_d4002b4fa6_w.jpg',
    },
    {
      'nomeProduto': 'Suco de laranja',
      'descricaoProduto': 'Pastel Carne recheado',
      'precoProduto': 'Pastel Carne',
      'imageProduto':
          'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg',
    }
  ];

  List<Widget> output = [];

  void itemSelecionado() {
    setState(() {
      if (_selectedCategory == "SALGADOS") {
        output.clear();
        for (var i = 0; i < salgados.length; i++) {
          output.add(Cardapio(
              onTap: () =>
                  {Navigator.pushNamed(context, '/produto-selecionado')},
              imageProduto: salgados[i]['imageProduto'],
              descricaoProduto: salgados[i]['descricaoProduto'],
              nomeProduto: salgados[i]['nomeProduto'],
              precoProduto: salgados[i]['precoProduto']));
        }
      } else if (_selectedCategory == "DOCES") {
        output.clear();
        for (var i = 0; i < doces.length; i++) {
          output.add(Cardapio(
              onTap: () =>
                  {Navigator.pushNamed(context, '/produto-selecionado')},
              imageProduto: doces[i]['imageProduto'],
              descricaoProduto: doces[i]['descricaoProduto'],
              nomeProduto: doces[i]['nomeProduto'],
              precoProduto: doces[i]['precoProduto']));
        }
      } else if (_selectedCategory == "BEBIDAS") {
        output.clear();
        for (var i = 0; i < bebidas.length; i++) {
          output.add(Cardapio(
              onTap: () =>
                  {Navigator.pushNamed(context, '/produto-selecionado')},
              imageProduto: bebidas[i]['imageProduto'],
              descricaoProduto: bebidas[i]['descricaoProduto'],
              nomeProduto: bebidas[i]['nomeProduto'],
              precoProduto: bebidas[i]['precoProduto']));
        }
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
                print('Clique profile navbar');
              },
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
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
              itemCategoryNavigation(),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: output,
                ),
              )
            ],
          ),
        ),
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
    );
  }

  SingleChildScrollView itemCategoryNavigation() {
    return SingleChildScrollView(
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
                  itemSelecionado();
                })
              },
              child: Text(
                'SALGADOS',
                style: TextStyle(
                  color: _selectedCategory == "SALGADOS"
                      ? const Color.fromARGB(255, 198, 6, 6)
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () => {
                setState(() {
                  _selectedCategory = "DOCES";
                  itemSelecionado();
                })
              },
              child: Text(
                'DOCES',
                style: TextStyle(
                  color: _selectedCategory == "DOCES"
                      ? const Color.fromARGB(255, 198, 6, 6)
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () => {
                setState(() {
                  _selectedCategory = "BEBIDAS";
                  itemSelecionado();
                })
              },
              child: Text(
                'BEBIDAS',
                style: TextStyle(
                  color: _selectedCategory == "BEBIDAS"
                      ? const Color.fromARGB(255, 198, 6, 6)
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
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
