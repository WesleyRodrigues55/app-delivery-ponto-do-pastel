import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:app_delivery_ponto_do_pastel/components/myDrawer.dart';
import 'package:intl/intl.dart';

class MyData extends StatefulWidget {
  const MyData({super.key});

  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  Map<dynamic, dynamic>? userSelected;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var userID = sharedPreferences.getString('userId');

    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/users/users-by-id/$userID');

    var headers = {'Authorization': 'Bearer $token'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      setState(() {
        userSelected = data['results'];
        isLoading = false; // Indica que os dados foram carregados
      });
    } else {
      setState(() {
        isLoading = false; // Indica que ocorreu um erro ao carregar os dados
      });
    }
  }

  String formatDate(String dateString) {
    final DateTime parsedDate = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (userSelected == null) {
      // Dados carregados, mas a lista de produtos está vazia
      return const Center(
        child: Text('Nenhum usuário encontrado'),
      );
    } else {
      return TelaUserSelecionadoPorId(
        nomeUsuario: userSelected!['nome'],
        cpfUsuario: userSelected!['cpf'],
        dataNascimento: formatDate(userSelected!['data_nascimento'].toString()),
        // email: user!['email'],
        whatsApp: userSelected!['whatsapp'],
      );
    }
  }
}

class TelaUserSelecionadoPorId extends StatelessWidget {
  const TelaUserSelecionadoPorId({
    super.key,
    required this.nomeUsuario,
    required this.cpfUsuario,
    required this.dataNascimento,
    // required this.email,
    required this.whatsApp,
  });

  final String nomeUsuario;
  final String cpfUsuario;
  final String dataNascimento;
  // final String email;
  final String whatsApp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Dados"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: const Color.fromARGB(255, 241, 241, 241),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Nome'),
                        trailing: Text(
                          nomeUsuario,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('CPF'),
                        trailing: Text(
                          cpfUsuario,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Data Nascimento'),
                        trailing: Text(
                          dataNascimento,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      // const Divider(),
                      // ListTile(
                      //   title: const Text('E-mail'),
                      //   trailing: Text(
                      //     widget.email,
                      //     style: const TextStyle(
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.black),
                      //   ),
                      // ),
                      const Divider(),
                      ListTile(
                        title: const Text('WhatsApp'),
                        trailing: Text(
                          whatsApp,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 33.0),
          ],
        ),
      ),
    );
  }
}
