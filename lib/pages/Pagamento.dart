import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Carrinho.dart';
import 'package:app_delivery_ponto_do_pastel/pages/CheckoutCompra.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:app_delivery_ponto_do_pastel/pages/PagamentoRecebido.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Pagamento extends StatefulWidget {
  const Pagamento({super.key});

  @override
  State<StatefulWidget> createState() => _PagamentoState();
}

class _PagamentoState extends State<Pagamento> {
  final linkPix = TextEditingController();
  bool isLoading = true;
  String? qrCodesImage;
  int? id_payment;
  Timer? timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    id_payment = ModalRoute.of(context)?.settings.arguments as int?;
    fetchStatusCompra(id_payment);
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchStatusCompra(id_payment);
    });
  }

   @override
  void dispose() {
    // Cancela o temporizador no dispose
    timer?.cancel();
    super.dispose();
  }

  Future<void> fetchStatusCompra(idPayment) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
        'http://localhost:5000/api/payment/get-status-payment/$idPayment');

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data = data['results'];
      var statusPagamento = data['status'];
      qrCodesImage = data['point_of_interaction']['transaction_data']['qr_code_base64'];
      linkPix.text = data['point_of_interaction']['transaction_data']['qr_code'];

      if (statusPagamento == "approved") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PagamentoRecebido(),
          ),
        );
      }
      setState(() {
        isLoading = false; 
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aguardando pagamento'),
        // Desativa o botão de voltar padrão
        automaticallyImplyLeading: false,
        // Define uma ação personalizada para o botão de voltar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Substitui a tela atual por uma nova tela
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => CheckoutCompra()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 120, left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Center(
                  child: Container(
                child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.network("data:image/jpeg;base64,$qrCodesImage")),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Faça o pagamento através do QRCode \n OU \n Copie o link abaixo ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
              InputCustom(
                  controllerName: linkPix,
                  label: 'PIX COPIA E COLA',
                  placeholder: 'copia.pix.xxxxxxxxxxxx/qr.code.bradesco...',
                  keyboardType: TextInputType.text),
            ],
          ),
        ),
      ),
    );
  }
}
