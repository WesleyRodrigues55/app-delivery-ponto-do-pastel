import 'dart:async';
import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PagamentoRecebido extends StatefulWidget {
  const PagamentoRecebido({super.key});

  @override
  State<PagamentoRecebido> createState() => _PagamentoRecebidoState();
}

class _PagamentoRecebidoState extends State<PagamentoRecebido> {
  Timer? timer;
  String? idOrderDetails;
  int indexStatus = 0;
  bool isLoading = true;
  Widget? child;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      fetchGetStatusOrder(idOrderDetails.toString());
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchGetStatusOrder(idOrderDetails) async {
    idOrderDetails = ModalRoute.of(context)?.settings.arguments as String?;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
        'http://localhost:5000/api/order-details/get-status-order-details/$idOrderDetails');
    // var url = Uri.parse(
    //     'https://backend-delivery-ponto-do-pastel.onrender.com/api/payment/get-status-payment/$idPayment');

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var statusPedido = data['results'];

      if (statusPedido == "pendente") {
        setState(() {
          indexStatus = 0;
          isLoading = false; 
        });
      } else if (statusPedido == "em preparo") {
        setState(() {
          indexStatus = 1;
          isLoading = false; 
        });
      } else if (statusPedido == "a caminho") {
        setState(() {
          indexStatus = 2;
          isLoading = false; 
        });
      } else {
        setState(() {
          isLoading = false; 
        });
      }
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   idOrderDetails = ModalRoute.of(context)?.settings.arguments as String?;
  //   fetchGetStatusOrder(idOrderDetails.toString());
  // }



  @override
  Widget build(BuildContext context) {


    if (indexStatus == 0) {
      child = PagamentoAprovado();
    } else if (indexStatus == 1) {
      child = PedidoEmPreparo();
    } else if (indexStatus == 2) {
      child = PedidoACaminho();
    } else {

    }

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
            child: child!
          ),
        ));
  }
}

class PagamentoAprovado extends StatelessWidget {
  const PagamentoAprovado({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/dollar.png',
            height: 160,
            width: 200,
          ),
          SizedBox(
            height: 20,
          ),
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
    );
  }
}

class PedidoEmPreparo extends StatelessWidget {
  const PedidoEmPreparo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/deep-fryer.png',
            height: 160,
            width: 200,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Pedido em preparo!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Seu pedido está em preparo, aguarde...', style: TextStyle(fontSize: 14),),
          SizedBox(
            height: 10,
          ),
          LoadingAnimationWidget.staggeredDotsWave(
            color: Color.fromARGB(255, 198, 6, 6),
            size: 50,
          ),
        ],
      ),
    );
  }
}

class PedidoACaminho extends StatelessWidget {
  const PedidoACaminho({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/delivery-bike.png',
            height: 160,
            width: 200,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Pedido a caminho!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Seu pedido está a caminho', style: TextStyle(fontSize: 14),),
          Text('Dentro de 50min seu pedido será entregue', style: TextStyle(fontSize: 14),),
          SizedBox(
            height: 10,
          ),
          LoadingAnimationWidget.staggeredDotsWave(
            color: Color.fromARGB(255, 198, 6, 6),
            size: 50,
          ),
        ],
      ),
    );
  }
}
