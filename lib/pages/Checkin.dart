import 'package:app_delivery_ponto_do_pastel/components/input.dart';
import 'package:app_delivery_ponto_do_pastel/components/primaryButton.dart';
import 'package:flutter/material.dart';

class Checkin extends StatefulWidget {
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  final _nomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text(
              'Valide sua Conta',
              style: TextStyle(
                color: Color.fromRGBO(132, 147, 172, 1),
                fontFamily: 'OutFIT',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InputCustom(
                label: 'Digite o código recebido',
                placeholder: 'Exemplo: 4AJBC',
                controllerName: _nomeController,
                validation: (value) {
                  if (value == null || value.length < 5) {
                    return 'Digite um nome de usuário válido!';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 33.0),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PrimaryButton(
                onPressed: () {},
                title: 'Continuar',
                extraLarge: 1,
                text: '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
