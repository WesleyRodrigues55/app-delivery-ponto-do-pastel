// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _keepLoggedIn = false;
  final _nomeController = TextEditingController();
  final _whatsappController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/logo-pastel-fundo-amarelo.jpg',
                ),
                radius: 120,
                // maxRadius: 90,
              ),
              const Text('Nome',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit')),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.6,
                      color: const Color(
                          0xFFC60606)), // Alteração na grossura da borda
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    hintText: 'Digite o seu Nome',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('WhatsApp',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit')),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.6,
                      color: const Color(
                          0xFFC60606)), // Alteração na grossura da borda
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _whatsappController,
                  decoration: const InputDecoration(
                    hintText: 'Digite o seu WhatsApp',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Checkbox(
                    value: _keepLoggedIn,
                    onChanged: (value) {
                      setState(() {
                        _keepLoggedIn = value!;
                      });
                    },
                  ),
                  const Text('Manter conectado'),
                ],
              ),
              const SizedBox(height: 33.0),
              PrimaryButton(
                title: 'Entrar',
                extraLarge: 1,
              ),
              SizedBox(height: 20),
              Center(
                  child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                              title: 'teste',
                            )),
                  );
                },
                child: Text(
                  'Não tem uma conta? Registre agora',
                  style: TextStyle(
                      color: Color.fromARGB(62, 0, 0, 0),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit'),
                ),
              )),
              const SizedBox(height: 10),
              PrimaryButton(
                bgButton: Colors.black,
                title: 'Entrar com o Google+',
                extraLarge: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
