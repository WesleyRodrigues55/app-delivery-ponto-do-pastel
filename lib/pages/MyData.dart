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
  int _currentIndex = 0;
  bool isLoading = true;
  Map<String, dynamic>? user;

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

    if (token == null) {
      print('Token is null');
      setState(() {
        isLoading = false;
      });
      return;
    }

    var headers = {'Authorization': 'Bearer $token'};
    print('Fetching user with token: $token');

    try {
      var response = await http.get(url, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Decoded data: $data');

        setState(() {
          user = data['results'];
          isLoading = false;
        });
      } else {
        print('Failed to load user data');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
      setState(() {
        isLoading = false;
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
    } else if (user == null) {
      return const Center(
        child: Text('Nenhum usuario encontrado'),
      );
    } else {
      return TelaUserSelecionadoPorId(
        nomeUsuario: user!['nome'],
        cpfUsuario: user!['cpf'],
        dataNascimento: formatDate(user!['data_nascimento'].toString()),
        email: user!['email'],
        whatsApp: user!['whatsapp'],
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
            const SizedBox(height: 22.0),
            const Text(
              "Meus Dados",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OutFIT',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(height: 22.0),
            const Divider(),
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Nome'),
                      trailing: Text(
                        widget.nomeUsuario,
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
                        widget.cpfUsuario,
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
                        widget.dataNascimento,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('E-mail'),
                      trailing: Text(
                        widget.email,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('WhatsApp'),
                      trailing: Text(
                        widget.whatsApp,
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
            const SizedBox(height: 33.0),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
