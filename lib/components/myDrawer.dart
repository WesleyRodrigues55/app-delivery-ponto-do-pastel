import 'package:app_delivery_ponto_do_pastel/pages/BoasVindas.dart';
import 'package:app_delivery_ponto_do_pastel/pages/MyData.dart';
import 'package:app_delivery_ponto_do_pastel/pages/PrivacyPolicies.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      child: Padding(
        padding: EdgeInsets.only(top: 20, right: 0, left: 20),
        child: Column(
          children: [logoutDrawer(), itemsDrawer()],
        ),
      ),
    );
  }
}

class itemsDrawer extends StatelessWidget {
  const itemsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('Meu Perfil'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyData(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.policy),
                title: const Text('Políticas de Privacidade'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicies(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: const Text('Dúvidas Frequentes'),
                onTap: () {},
              ),
            ],
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.message),
                title: const Text('Fale Conosco'),
                onTap: () {
                  // abre wpp do suporte
                  print('Fale Conosco');
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}

class logoutDrawer extends StatelessWidget {
  const logoutDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Finalizar sessão',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.logout,
            color: Colors.black,
          )
        ],
      ),
      onTap: () async {
        bool isLogout = await logout();
        if (isLogout) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BoasVindas()),
          );
        }
      },
    );
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
