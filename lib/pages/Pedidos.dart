import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pedidos extends StatefulWidget {
  const Pedidos({super.key});

  @override
  State<Pedidos> createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/checklist.png",
              height: 180,
            ),
            SizedBox(height: 20,),
            Text("Não há pedidos por aqui...",),
            PrimaryButton(
              title: "Comece a comprar agora!", 
              extraLarge: 0, 
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              }
            )
          ],
        ),

      //body: SingleChildScrollView(
        // child: Form(
        //   key: formKey,
        //   child: const Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.all(20.0),
        //         child: Text(
        //           'Meus Pedidos',
        //           style: TextStyle(
        //             fontFamily: 'OutFIT',
        //             fontWeight: FontWeight.bold,
        //             fontSize: 18,
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //           title: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 'Nº Pedido: 12345',
        //                 style: TextStyle(
        //                     fontSize: 14, fontWeight: FontWeight.bold),
        //               ),
        //               Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text('Valor Total: R\$ 50,00'),
        //                 ],
        //               ),
        //             ],
        //           ),
        //           trailing: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text(
        //                 "Data da compra:",
        //                 style: TextStyle(color: Colors.grey),
        //               ),
        //               Text('27/05/2024')
        //             ],
        //           )),
        //       Divider(),
        //     ],
        //   )
        // ),
      ),
    );
  }
}
