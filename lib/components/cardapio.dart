import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/pages/ProdutoSelecionado.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cardapio extends StatefulWidget {
  const Cardapio({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<Cardapio> createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/product/get-products-by-category/${widget.category.toLowerCase()}');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        products = data['results'];
        isLoading = false; // Indica que os dados foram carregados
      });
    } else {
      setState(() {
        isLoading = false; // Indica que ocorreu um erro ao carregar os dados
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Dados ainda estão sendo carregados
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (products.isEmpty) {
      // Dados carregados, mas a lista de produtos está vazia
      return const Center(
        child: Text('Nenhum produto encontrado'),
      );
    } else {
      // Dados carregados e há produtos na lista
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int i) {
          return SingleChildScrollView(
            child: CardapioItems(
                // onTap: () => {Navigator.pushNamed(context, '/produto-selecionado', arguments: products[i]['_id'])},
                onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProdutoSelecionado(),
                          settings: RouteSettings(
                            arguments: {
                              "id_produto": products[i]['_id'],
                              "categoria": widget.category
                            },
                          ),
                        ),
                      )
                    },
                imageProduto: products[i]['imagem_produto'].toString(),
                descricaoProduto: products[i]['descricao'],
                nomeProduto: products[i]['nome'],
                precoProduto: products[i]['preco'].toString()),
          );
        },
      );
    }
  }
}

class CardapioItems extends StatelessWidget {
  const CardapioItems({
    super.key,
    required this.onTap,
    required this.nomeProduto,
    required this.descricaoProduto,
    required this.precoProduto,
    required this.imageProduto,
  });

  final void Function()? onTap;
  final String nomeProduto;
  final String descricaoProduto;
  final String precoProduto;
  final String imageProduto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        nomeProduto,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        descricaoProduto,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Preço: R\$$precoProduto",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontFamily: 'Outfit-Bold',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  height: 100,
                  child: Image.network(
                    imageProduto,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 10),
      ],
    );
  }
}
