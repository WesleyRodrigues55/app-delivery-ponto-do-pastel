import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/components/input.dart';
import 'package:app_delivery_ponto_do_pastel/components/primaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Checkin extends StatefulWidget {
  const Checkin({super.key});

  @override
  State<Checkin> createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  final formKey = GlobalKey<FormState>();
  final _codigoAcessoController = TextEditingController();

  void validaCampos() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (formKey.currentState!.validate()) {
      bool isTrueLogin = await sendCodeVerification();
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      if (isTrueLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        _codigoAcessoController.clear();
        SnackBarUtils.showSnackBar(context, 'Código inválido!',
            color: Colors.red);
      }
    } else {
      SnackBarUtils.showSnackBar(context, 'Os campos precisam ser preenchidos',
          color: Colors.red);
    }
  }

  @override
  void dispose() {
    _codigoAcessoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Valide sua Conta',
                  style: TextStyle(
                    color: Color.fromRGBO(132, 147, 172, 1),
                    fontFamily: 'OutFIT',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                InputCustom(
                  keyboardType: TextInputType.text,
                  label: 'Digite o código recebido',
                  placeholder: 'Exemplo: B8B814',
                  controllerName: _codigoAcessoController,
                  validation: (value) {
                    if (value == null || value.length < 6 || value.length > 6) {
                      return 'Digitie o código de 6 dígitos recebido!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 33.0),
                PrimaryButton(
                  onPressed: () async => validaCampos(),
                  title: 'Entrar',
                  extraLarge: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> sendCodeVerification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // recebe id do produto selecionado
    var wpp = ModalRoute.of(context)!.settings.arguments;

    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/auth/authenticator-code-app');

    var headers = {'Content-Type': 'application/json'};
    var data = {'username': wpp, 'senha': _codigoAcessoController.text};

    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final token = response.headers['authorization'];
      await sharedPreferences.setString('token', token.toString());
      return true;
    } else {
      SnackBarUtils.showSnackBar(
          context, 'Código inválido, por favor, tente novamente!',
          color: Colors.red);
      return false;
    }
  }
}
