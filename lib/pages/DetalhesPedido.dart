import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetalhesPedido extends StatefulWidget {
  final String idCarrinho;

  const DetalhesPedido({Key? key, required this.idCarrinho}) : super(key: key);

  @override
  _DetalhesPedidoState createState() => _DetalhesPedidoState();
}

class _DetalhesPedidoState extends State<DetalhesPedido> {
  Map<String, dynamic>? detalhesPedido;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetalhesPedido();
  }

  Future<void> fetchDetalhesPedido() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    var headers = {"Authorization": "Bearer $token"};
    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/order-details/${widget.idCarrinho}');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        detalhesPedido = data['result'];
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
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Pedido'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (detalhesPedido == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Detalhes do Pedido'),
          ),
          body: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Text(
                                '1x',
                                style: TextStyle(fontSize: 20),
                              ),
                              title: Text(
                                'Pastel de Frango',
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('R\$ 10,00'),
                                  Text('Adicional Recheio extra'),
                                  Text('Adicional Morango'),
                                  Text('Adicional: Confete')
                                ],
                              ),
                              trailing: Image.network(
                                  'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg'),
                            ),
                            Divider(),
                            ListTile(
                              leading: Text(
                                '1x',
                                style: TextStyle(fontSize: 20),
                              ),
                              title: Text(
                                'Coca-Cola 350ML Lata',
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('R\$ 5,90'),
                                ],
                              ),
                              trailing: Image.network(
                                  'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 300, // Define a largura desejada
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 231, 231),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Define o tamanho mínimo para o eixo principal (vertical)
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TOTAL',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'R\$ 15,90',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Pedido'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID do Carrinho: ${widget.idCarrinho}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Data do Pedido: ${detalhesPedido!['data_pedido']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Valor Total: R\$ ${detalhesPedido!['valor_total']}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }
  }
}
