import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pagamento extends StatefulWidget {
  const Pagamento({super.key});

  @override
  State<StatefulWidget> createState() => _PagamentoState();
}

class _PagamentoState extends State<Pagamento> {
  final _linkPix = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aguardando pagamento'),
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
                    child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-SAnzQR1OYIQWiv4yLuCinQunCai6hinWcA&usqp=CAU')),
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
                  controllerName: _linkPix,
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
