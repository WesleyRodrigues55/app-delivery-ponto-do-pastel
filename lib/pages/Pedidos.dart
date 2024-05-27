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
      body: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        )
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
