import 'package:app_delivery_ponto_do_pastel/pages/BoasVindas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ponto do pastel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 198, 6, 6)),
        useMaterial3: true,
        fontFamily: 'Outfit',
      ),
      home: const BoasVindas(),
    );
  }
}
