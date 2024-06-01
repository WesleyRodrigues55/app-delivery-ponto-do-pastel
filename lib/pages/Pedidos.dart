import 'dart:convert';
import 'package:app_delivery_ponto_do_pastel/components/OrdersEmpty.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:http/http.dart' as http;
import 'DetalhesPedido.dart'; // Certifique-se de que o caminho esteja correto

class PagePedidos extends StatefulWidget {
  PagePedidos({super.key});

  @override
  State<PagePedidos> createState() => _PagePedidosState();
}

class _PagePedidosState extends State<PagePedidos> {
  List<dynamic> pedidos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPedidos();
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

  Future<void> fetchPedidos() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    String? idUser = sharedPreferences.getString("userId");
    var headers = {"Authorization": "Bearer $token"};
    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/order-details/get-orders-by-id-user/$idUser');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        pedidos = data['results'];
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
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (pedidos.isEmpty) {
      return OrdersEmpty();
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Meus Pedidos',
                style: TextStyle(
                  fontFamily: 'OutFIT',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pedidos.length,
              itemBuilder: (BuildContext context, int i) {
                return Pedidos(
                  idCarrinho: pedidos[i]['carrinho_id'],
                  dataCompra: formatDate(pedidos[i]['data_pedido']),
                  horaCompra: formatHour(pedidos[i]['data_pedido']),
                  numeroPedido: i + 1,
                  statusPedido: pedidos[i]['status_pedido'],
                  valorTotal: pedidos[i]['valor_total'],
                );
              },
            ),
          ],
        ),
      );
    }
  }
}

class Pedidos extends StatelessWidget {
  const Pedidos({
    super.key,
    required this.numeroPedido,
    required this.valorTotal,
    required this.dataCompra,
    required this.statusPedido,
    required this.horaCompra,
    required this.idCarrinho,
  });

  final int numeroPedido;
  final String valorTotal;
  final String dataCompra;
  final String statusPedido;
  final String horaCompra;
  final String idCarrinho;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesPedido(idCarrinho: idCarrinho),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nº Pedido: $numeroPedido - $statusPedido',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Valor Total: R\$ $valorTotal'),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Data da compra:"
                ),
                Text("$dataCompra às $horaCompra"),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
