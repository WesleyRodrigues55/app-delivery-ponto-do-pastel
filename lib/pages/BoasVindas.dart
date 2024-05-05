import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:app_delivery_ponto_do_pastel/pages/login.dart';
import 'package:flutter/material.dart';

class BoasVindas extends StatefulWidget {
  const BoasVindas({super.key});

  @override
  State<BoasVindas> createState() => _BoasVindasState();
}

class _BoasVindasState extends State<BoasVindas> {
  @override
  void initState() {
    super.initState();
    verificarToken().then((value) {
      if (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<bool> verificarToken() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // if (sharedPreferences.getString('token') != null) {
    //   return true;
    // } else {
    //   return false;
    // }
    return true;
  }
}
