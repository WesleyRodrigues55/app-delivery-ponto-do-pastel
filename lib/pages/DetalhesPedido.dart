import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetalhesPedido extends StatefulWidget {
  const DetalhesPedido({
    super.key, 
    required this.idCarrinho
  });

  final String idCarrinho;

  @override
  _DetalhesPedidoState createState() => _DetalhesPedidoState();
}

class _DetalhesPedidoState extends State<DetalhesPedido> {
  List<dynamic> detalhesPedido = [];
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
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/order-details/get-orders-details-by-id-carrinho/${widget.idCarrinho}');

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        detalhesPedido = data['results'];
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
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (detalhesPedido.isEmpty) {
      return const Center(
        child: Text('Nenhum detalhe do pedido encontrado'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Pedido'),
        ),
        body: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: detalhesPedido.length,
                itemBuilder: (BuildContext context, int i) {
                  return DetalhesPedidoView(
                    observacao: detalhesPedido[i]['itens_carrinho'][i]['observacao'],
                    listItensPedido: detalhesPedido[i]['itens_carrinho'],
                    dataAbertura: detalhesPedido[i]['carrinho'][i]['data_abertura'],
                    statusCompra: detalhesPedido[i]['carrinho'][i]['status_compra'],
                    taxaFixa: detalhesPedido[i]['carrinho'][i]['taxa_fixa'],
                    valorTotalComTaxa: detalhesPedido[i]['carrinho'][i]['valor_total_com_taxa'],
                    valorTotalCompra: detalhesPedido[i]['carrinho'][i]['valor_total_compra'],
                  );
                },
              ),
      );
    }
  }
}

class DetalhesPedidoView extends StatelessWidget {
  DetalhesPedidoView({
    super.key,
    required this.observacao,
    required this.statusCompra,
    required this.dataAbertura,
    required this.taxaFixa,
    required this.valorTotalComTaxa,
    required this.valorTotalCompra,
    required this.listItensPedido,
  });

  String observacao;
  String statusCompra;
  String dataAbertura;
  String taxaFixa;
  String valorTotalComTaxa;
  String valorTotalCompra;
  List<dynamic> listItensPedido;

  String formatToTwoDecimalPlaces(String value) {
    final number = double.parse(value);
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(number);
  }

  String formatDate(String dateString) {
    final DateTime parsedDate = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(parsedDate);
  }


  String formatHour(String hourString) {
    final DateTime parsedDate = DateTime.parse(hourString).subtract(Duration(hours: 3));
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(parsedDate);
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listItensPedido.length,
                itemBuilder: (BuildContext context, int i) {
                  return ItensPedido(
                    imagemProduto: listItensPedido[i]['produto']['imagem_produto'],
                    nomeProduto: listItensPedido[i]['produto']['nome'],
                    precoProduto: listItensPedido[i]['produto']['preco'],
                    quantidadeProduto: listItensPedido[i]['quantidade'],
                    listAdicionais: listItensPedido[i]['lista_ingredientes'],
                  );
                },
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                color: Color.fromARGB(255, 231, 231, 231),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Define o tamanho mínimo para o eixo principal (vertical)
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Data Pedido', style: TextStyle(fontSize: 14)),
                        Text('${formatDate(dataAbertura)} às ${formatHour(dataAbertura)}', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status Pedido', style: TextStyle(fontSize: 14)),
                        Text('$statusCompra', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: TextStyle(fontSize: 14)),
                        Text('R\$ ${formatToTwoDecimalPlaces(valorTotalCompra)}', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Taxa Fixa de Entrega', style: TextStyle(fontSize: 14)),
                        Text('R\$ ${formatToTwoDecimalPlaces(taxaFixa)}', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'R\$ ${formatToTwoDecimalPlaces(valorTotalComTaxa)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItensPedido extends StatelessWidget {
  const ItensPedido({
    super.key,
    required this.nomeProduto,
    required this.precoProduto,
    required this.quantidadeProduto,
    required this.imagemProduto,
    required this.listAdicionais,
  });

  final String nomeProduto;
  final String precoProduto;
  final String imagemProduto;
  final int quantidadeProduto;
  final List<dynamic> listAdicionais;

  String formatToTwoDecimalPlaces(String value) {
    final number = double.parse(value);
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(number);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Text(
            '${quantidadeProduto}x',
            style: TextStyle(fontSize: 20),
          ),
          title: Text(
            nomeProduto,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('R\$ ${formatToTwoDecimalPlaces(precoProduto)}'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listAdicionais.length,
                itemBuilder: (BuildContext context, int i) {
                  return Text('Adicional ${listAdicionais[i]['nome']}');
                },
              ),
            ],
          ),
          trailing: Image.network(imagemProduto),
        ),
        Divider(),
      ],
    );
  }
}
