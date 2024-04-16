import 'package:flutter/material.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Nome',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit')),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.6,
                  color: Color(0xFFC60606)), // Alteração na grossura da borda
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text('WhatsApp'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.6,
                  color: Color(0xFFC60606)), // Alteração na grossura da borda
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              controller: _whatsappController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20.0),
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
              Text('Manter conectado'),
            ],
          ),
          SizedBox(height: 33.0),
          SizedBox(
            height: 40.51,
            child: ElevatedButton(
              onPressed: () {
                // Implemente a lógica para autenticar o usuário aqui
                String nome = _nomeController.text.trim();
                String whatsapp = _whatsappController.text.trim();
                bool keepLoggedIn = _keepLoggedIn;

                // Exemplo: Imprimir os dados do usuário
                print('Nome: $nome');
                print('WhatsApp: $whatsapp');
                print('Manter conectado: $keepLoggedIn');
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(159.0, 40.51)),
                backgroundColor: MaterialStateProperty.all(Color(0xFFC60606)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              child: Text('Entrar'),
            ),
          ),
        ],
      ),
    );
  }
}
