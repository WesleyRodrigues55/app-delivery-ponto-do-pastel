import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Login.dart';
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
        '/login': (context) => Login(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 198, 6, 6)),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'LOGO'),
    );
  }
}
