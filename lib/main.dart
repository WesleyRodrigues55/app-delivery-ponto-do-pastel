import 'package:app_delivery_ponto_do_pastel/pages/ProdutoSelecionado.dart';
import 'package:app_delivery_ponto_do_pastel/pages/checkin.dart';
import 'package:app_delivery_ponto_do_pastel/pages/home.dart';
import 'package:app_delivery_ponto_do_pastel/pages/login.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'LOGO'),
        '/login': (context) => const Login(),
        '/login/checkin': (context) => const Checkin(),
        '/produto-selecionado': (context) => const ProdutoSelecionado(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 6, 6)),
        useMaterial3: true,
        fontFamily: 'Outfit',
      ),
    );
  }
}
