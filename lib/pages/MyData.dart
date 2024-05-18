import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/components/myDrawer.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyData extends StatefulWidget {
  const MyData({super.key});

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  int _currentIndex = 0;
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;

  List<dynamic> user = [];
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/users/users-by-id/662bfd4dbd64ba8fa991f75a');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var headers = {'Authorization': 'Bearer $token'};

    var response = await http.get(url, headers: headers);

    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      setState(() {
        user = data['results'];
        isLoading = false; // Indica que os dados foram carregados
      });
    } else {
      setState(() {
        isLoading = false; // Indica que ocorreu um erro ao carregar os dados
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Dados ainda estão sendo carregados
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (user.isEmpty) {
      // Dados carregados, mas a lista de produtos está vazia
      return const Center(
        child: Text('Nenhum produto encontrado'),
      );
    } else {
      //Dados carregados e há produtos na lista
      return ListView.builder(
        itemCount: user.length,
        itemBuilder: (BuildContext context, int i) {
          return SingleChildScrollView(
            child: TelaUserSelecionadoPorId(
              nomeUsuario: user[i]['nome'],
              cpfUsuario: user[i]['cpf'],
              dataNascimento: user[i]['data_nascimento'].toString(),
              email: user[i]['email'],
              whatsApp: user[i]['whatsapp'],
            ),
          );
        },
      );
    }
  }
}

class TelaUserSelecionadoPorId extends StatefulWidget {
  const TelaUserSelecionadoPorId({
    super.key,
    required this.nomeUsuario,
    required this.cpfUsuario,
    required this.dataNascimento,
    required this.email,
    required this.whatsApp,
  });

  final String nomeUsuario;
  final String cpfUsuario;
  final String dataNascimento;
  final String email;
  final String whatsApp;

  @override
  State<TelaUserSelecionadoPorId> createState() =>
      _TelaUserSelecionadoPorIdState();
}

class _TelaUserSelecionadoPorIdState extends State<TelaUserSelecionadoPorId> {
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
            const SizedBox(height: 33.0),
            Divider(),
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Nome'),
                      trailing: Text(
                        widget.nomeUsuario,
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
                    Divider(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 33.0),
          ],
        ),
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _currentIndex,
        // onTap: (index) => {
        //   setState(() {
        //     _currentIndex = index;
        //   })
        // },
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
