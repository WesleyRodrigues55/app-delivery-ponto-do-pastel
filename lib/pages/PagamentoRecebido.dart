import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PagamentoRecebido extends StatelessWidget {
  const PagamentoRecebido({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 231, 231, 231),
          title: Text("Status pedido"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navega para outra tela ao pressionar o botão de voltar
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/dollar.png'),
                Text(
                  'Pagamento aprovado!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Seu pedido foi recebido, aguarde a aprovação do estabelecimento.', style: TextStyle(fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Color.fromARGB(255, 198, 6, 6),
                  size: 50,
                ),
              ],
            ),
          ),
        ));
  }
}
