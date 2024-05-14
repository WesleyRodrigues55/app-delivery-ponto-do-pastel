import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProdutoSelecionadoPorId extends StatefulWidget {
  const ProdutoSelecionadoPorId({super.key});

  @override
  State<ProdutoSelecionadoPorId> createState() =>
      _ProdutoSelecionadoPorIdState();
}

class _ProdutoSelecionadoPorIdState extends State<ProdutoSelecionadoPorId> {
  bool isLoading = true;
  List<dynamic> product = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var id = ModalRoute.of(context)?.settings.arguments;
    fetchProduct(id);
  }


  Future<void> fetchProduct(id) async {
    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/product/product-by-id/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        product = data['results'];
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
    } else if (product.isEmpty) {
      // Dados carregados, mas a lista de produtos está vazia
      return const Center(
        child: Text('Nenhum produto encontrado'),
      );
    } else {
      //Dados carregados e há produtos na lista
      return ListView.builder(
        itemCount: product.length,
        itemBuilder: (BuildContext context, int i) {
          return SingleChildScrollView(
            child: TelaProdutoSelecionadoPorId(
              nomeProduto: product[i]['nome'],
              descricaoProduto: product[i]['descricao'],
              precoProduto: product[i]['preco'].toString(),
              imagemProduto: product[i]['imagem_produto'],
            ),
          );
        },
      );
    }
  }
}

class TelaProdutoSelecionadoPorId extends StatefulWidget {
  const TelaProdutoSelecionadoPorId(
      {super.key,
      required this.nomeProduto,
      required this.descricaoProduto,
      required this.imagemProduto,
      required this.precoProduto});

  final String nomeProduto;
  final String descricaoProduto;
  final String imagemProduto;
  final String precoProduto;

  @override
  State<TelaProdutoSelecionadoPorId> createState() =>
      _TelaProdutoSelecionadoPorIdState();
}

class _TelaProdutoSelecionadoPorIdState
  extends State<TelaProdutoSelecionadoPorId> {
  final List<bool> _checkboxes = [false, false, false, false];
  final _obsController = TextEditingController();
  int quantidadeProduto = 1;

  void adicionarProduto() {
    setState(() {
      quantidadeProduto++;
    });
  }

  void removerProduto() {
    setState(() {
      if (quantidadeProduto > 1) {
        quantidadeProduto--;
      }
    });
  }

  @override
  void dispose() {
    _obsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            Image.network(widget.imagemProduto),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nomeProduto,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.descricaoProduto,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Preço: R\$${widget.precoProduto}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Alguma observação?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      InputCustom(
                        label: 'Alguma observação?',
                        placeholder:
                            'Caso tenho algo a informar, digite aqui =)',
                        controllerName: _obsController,
                        keyboardType: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Algum adicional?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      CheckboxListTile(
                        title: const Text("Queijo mussarela - R\$3,50"),
                        value: _checkboxes[0],
                        onChanged: (value) {
                          setState(() {
                            _checkboxes[0] = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text("Queijo cheddar - R\$4,50"),
                        value: _checkboxes[1],
                        onChanged: (value) {
                          setState(() {
                            _checkboxes[1] = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text("Tomate picado - R\$2,00"),
                        value: _checkboxes[2],
                        onChanged: (value) {
                          setState(() {
                            _checkboxes[2] = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text("Bacon picado - R\$4,50"),
                        value: _checkboxes[3],
                        onChanged: (value) {
                          setState(() {
                            _checkboxes[3] = value!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: removerProduto,
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  quantidadeProduto.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                    onPressed: adicionarProduto,
                                    icon: const Icon(Icons.add))
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: TextButton(
                                onPressed: () {},
                                child: const Text("Adicionar R\$ 10,00")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
