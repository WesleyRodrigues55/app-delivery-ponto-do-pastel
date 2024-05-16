import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/components/input.dart';
import 'package:app_delivery_ponto_do_pastel/components/primaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/CadastroUsuario.dart';
import 'package:app_delivery_ponto_do_pastel/pages/checkin.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final _whatsappController = TextEditingController();
  bool _keepLoggedIn = false;

  void validaCampos() {
    if (formKey.currentState!.validate()) {
      sendCodeVerification();
    } else {
      SnackBarUtils.showSnackBar(context, 'Os campos precisam ser preenchidos');
    }
  }

  @override
  void dispose() {
    _whatsappController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/logo-pastel-fundo-amarelo.jpg',
                  ),
                  radius: 80,
                ),
                InputCustom(
                  keyboardType: TextInputType.phone,
                  label: 'Digite o nº do seu WhatsApp',
                  placeholder: 'Somente numeros com o DDD',
                  controllerName: _whatsappController,
                  validation: (value) {
                    if (value == null || value.length < 10) {
                      return 'Digite um número de celular válido!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
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
                  onPressed: () {
                    validaCampos();
                  },
                  title: 'Receber código de acesso',
                  extraLarge: 1,
                ),
                const SizedBox(height: 20),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CadastroUsuario()),
                    );
                  },
                  child: const Text(
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
                  onPressed: () {},
                  bgButton: Colors.black,
                  title: 'Entrar com o Google+',
                  extraLarge: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendCodeVerification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
    'https://backend-delivery-ponto-do-pastel.onrender.com/api/auth/generator-code-app/${(_whatsappController.text.toString())}');
    var response = await http.put(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      sharedPreferences.setString('userId', data['results']['userId'].toString());
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Checkin(),
          settings: RouteSettings(
            arguments: _whatsappController.text.toString(),
          ),
        ),
      );
    } else {
      SnackBarUtils.showSnackBar(
          context, 'Ocorreu um erro ao validar seu whatsapp, tente novamente.',
          color: Colors.red);
    }
  }
}
