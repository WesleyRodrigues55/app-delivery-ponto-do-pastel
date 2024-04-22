import 'package:app_delivery_ponto_do_pastel/components/primaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/home.dart';
import 'package:app_delivery_ponto_do_pastel/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Checkin.dart';

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
        '/checkin': (context) => Checkin(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 6, 6)),
        useMaterial3: true,
      ),
    );
  }
}
