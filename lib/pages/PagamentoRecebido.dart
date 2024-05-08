import 'dart:html';

import 'package:app_delivery_ponto_do_pastel/pages/Carrinho.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PagamentoRecebido extends StatelessWidget {
  const PagamentoRecebido({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 231, 231, 231),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  print('Clique profile navbar');
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pagamento recebido',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Seu pedido está sendo preparado.', style: TextStyle(fontSize: 14),),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Pedido nº XX', style: TextStyle(fontSize: 14),)
                ],
              ),
            ),
          ),
        ));
  }
}
