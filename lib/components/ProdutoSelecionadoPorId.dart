import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

    // var data = ModalRoute.of(context)?.settings.arguments;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? idProduto = args?['id_produto'];

    fetchProduct(idProduto);
  }

  Future<void> fetchProduct(id) async {
    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/product/product-by-id-and-ingredients/$id');
    var response = await http.get(url);
    print(response.statusCode);

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
              idProduto: product[i]['_id'],
              nomeProduto: product[i]['nome'],
              descricaoProduto: product[i]['descricao'],
              precoProduto: product[i]['preco'].toString(),
              imagemProduto: product[i]['imagem_produto'],
              ingredientesAdicionais: product[i]['ingredientesAdicionais'],
            ),
          );
        },
      );
    }
  }
}

class TelaProdutoSelecionadoPorId extends StatefulWidget {
  const TelaProdutoSelecionadoPorId({
    super.key,
    required this.idProduto,
    required this.nomeProduto,
    required this.descricaoProduto,
    required this.imagemProduto,
    required this.precoProduto,
    required this.ingredientesAdicionais,
  });

  final String idProduto;
  final String nomeProduto;
  final String descricaoProduto;
  final String imagemProduto;
  final String precoProduto;
  final List<dynamic> ingredientesAdicionais;

  @override
  State<TelaProdutoSelecionadoPorId> createState() =>
      _TelaProdutoSelecionadoPorIdState();
}

class _TelaProdutoSelecionadoPorIdState extends State<TelaProdutoSelecionadoPorId> {
  final _obsController = TextEditingController();
  int quantidadeProduto = 1;
  double valorTotal = 0;
  late List<bool> _checkboxes;
  List<Map<dynamic, dynamic>> listAdicionais = [];

  

  @override
  void initState() {
    super.initState();
    valorTotal = double.parse(widget.precoProduto.toString());
    _checkboxes = List.generate(
      widget.ingredientesAdicionais.length, // Tamanho igual ao número de itens
      (index) => false, // Inicializar todos como false
    );
  }

  void adicionarProduto() {
    setState(() {
      quantidadeProduto++;
      calcularValorTotal();
    });
  }

  void removerProduto() {
    setState(() {
      if (quantidadeProduto > 1) {
        quantidadeProduto--;
        calcularValorTotal();
      }
    });
  }

  void calcularValorTotal() {
    double valorProduto = double.parse(widget.precoProduto);
    double valorAdicionais = 0;

    for (int i = 0; i < _checkboxes.length; i++) {
      if (_checkboxes[i]) {
        valorAdicionais += double.parse(widget.ingredientesAdicionais[i]['valor']);
      }
    }

    valorTotal = quantidadeProduto * (valorProduto + valorAdicionais);
  }

  @override
  void dispose() {
    _obsController.dispose();
    super.dispose();
  }

  void addItemInList(indexCheckbox) {
    double valorAdicionais = 0;
    listAdicionais.clear();
    for (int i = 0; i < _checkboxes.length; i++) {
      if (_checkboxes[i]) {
        listAdicionais.add(
          {
            "id": widget.ingredientesAdicionais[i]['_id'].toString(),
            "preco": double.parse(widget.ingredientesAdicionais[i]['valor'].toString()),
            "nome": widget.ingredientesAdicionais[i]['nome'].toString(),
          }
        );
      } 
    }
  }

  Future<bool> insertItemInCart(infosProduct) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var userID = sharedPreferences.getString('userId');
    
    var url = Uri.parse(
        'http://localhost:5000/api/items-cart/insert_item_in_cart/66368613152b884cf07deff0');

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var data = {
      "produto_id": infosProduct['idProduto'],
      "lista_ingredientes": infosProduct['adicionais'],
      "quantidade": infosProduct['qtd'],
      "preco_unitario": infosProduct['precoUnitario'],
      "preco_total": infosProduct['precoTotal']
    };

    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      SnackBarUtils.showSnackBar(
          context, 'Item adiciondo no carrinho!', color: Colors.green);
      return true;
    } else if (response.statusCode == 400) {
        SnackBarUtils.showSnackBar(
          context, 'Erro ao inserir produto no carrinho!',
          color: Colors.red);
      return false;
    } else {
      SnackBarUtils.showSnackBar(
          context, 'Erro ao inserir produto no carrinho',
          color: Colors.red);
      return false;
    }
  }

  void getInfosAndSubmitForm() {
    Map<String, dynamic> infosProduct = {
      "idProduto": widget.idProduto,
      "precoUnitario": widget.precoProduto.toString(),
      "precoTotal": valorTotal.toString(),
      "qtd": quantidadeProduto,
      "adicionais": listAdicionais,
      "observacao": _obsController.text,
    };

    // falta observação 
    
    insertItemInCart(infosProduct);



  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? categoria = args?['categoria'];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 220,
              child: Image.network(
                widget.imagemProduto,
                fit: BoxFit.cover, // Ajusta a imagem dentro do contêiner
              ),
            ),
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
                        label: 'Digite aqui sua observação',
                        placeholder:
                            'Caso tenho algo a informar, escreva aqui =)',
                        controllerName: _obsController,
                        keyboardType: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      categoria == 'salgados'
                          ? const Text(
                              "Algum adicional?",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          : const Text(""),
                      categoria == 'salgados'
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.ingredientesAdicionais.length,
                              itemBuilder: (BuildContext context, int i) {
                                return CheckboxListTile(
                                  title: Text(
                                      "${widget.ingredientesAdicionais[i]['nome']} - R\$${widget.ingredientesAdicionais[i]['valor']}"),
                                  value: _checkboxes[i],
                                  onChanged: (value) {
                                    setState(() {
                                      _checkboxes[i] = value!;
                                      addItemInList(_checkboxes[i]);
                                      calcularValorTotal();
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                );
                              },
                            )
                          : const Text(" "),
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
                                onPressed: getInfosAndSubmitForm,
                                child: Text(
                                    "Adicionar R\$${valorTotal.toStringAsFixed(2)}")),
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
