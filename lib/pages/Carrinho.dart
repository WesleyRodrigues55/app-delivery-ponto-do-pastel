import 'package:app_delivery_ponto_do_pastel/components/CartEmpty.dart';
import 'package:app_delivery_ponto_do_pastel/pages/CheckoutCompra.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  List<dynamic> itensCarrinho = [];
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    fetchItensCarrinho();
  }

  Future<void> fetchItensCarrinho() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    String? userId = sharedPreferences.getString('userId');

    var headers = {'Authorization': 'Bearer $token'};

    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/cart/get-cart-open-with-items-cart/$userId');
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        itensCarrinho = data['results'];
        isLoading = false; // Indica que os dados foram carregados
      });
    } else {
      setState(() {
        isLoading = false; // Indica que ocorreu um erro ao carregar os dados
      });
    }
  }


  void _existsItemsCart(listaCart) {
    setState(() {

      if (listaCart.isEmpty) {
        print("Alterando estado");
      } else {
        fetchItensCarrinho();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Dados ainda estão sendo carregados
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (itensCarrinho.isEmpty) {
      // Dados carregados, mas a lista de produtos está vazia
      return CartEmpty();
    } else {
      if (itensCarrinho[0]['itens_carrinho'].isEmpty) {
        return CartEmpty();
      }

      //Dados carregados e há produtos na lista
      return ListView.builder(
        itemCount: itensCarrinho.length,
        itemBuilder: (BuildContext context, int i) {
          return CarrinhoBuilder(
            idCarrinho: itensCarrinho[i]['_id'],
            enderecoUsuarioList: itensCarrinho[i]['endereco_usuario'],
            itensCarrinhoList: itensCarrinho[i]['itens_carrinho'],
            taxaFixa: itensCarrinho[i]['taxa_fixa'],
            valorTotalComTaxa: itensCarrinho[i]['valor_total_com_taxa'],
            valorTotalCompra: itensCarrinho[i]['valor_total_compra'],
            existsItemsCart: () => _existsItemsCart(itensCarrinho[i]['itens_carrinho']),
          );
        },
      );
    }
  }
}



class CarrinhoBuilder extends StatefulWidget {
  const CarrinhoBuilder(
      {super.key,
      required this.idCarrinho,
      required this.itensCarrinhoList,
      required this.enderecoUsuarioList,
      required this.taxaFixa,
      required this.valorTotalComTaxa,
      required this.valorTotalCompra,
      required this.existsItemsCart
    });

  final String idCarrinho;
  final String taxaFixa;
  final String valorTotalComTaxa;
  final String valorTotalCompra;
  final List<dynamic> itensCarrinhoList;
  final List<dynamic> enderecoUsuarioList;
  final VoidCallback existsItemsCart;

  @override
  State<CarrinhoBuilder> createState() => _CarrinhoBuilderState();
}

class _CarrinhoBuilderState extends State<CarrinhoBuilder> {

  

  void _onDeleteItem(String id) {
    setState(() {
      widget.itensCarrinhoList.removeWhere((item) => item['_id'] == id);
      if (widget.itensCarrinhoList.isEmpty) {
        widget.existsItemsCart();
      }
      widget.existsItemsCart();
    });
  }

  void continueBuyCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutCompra(),
        settings: RouteSettings(
          arguments: widget.idCarrinho
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Itens Carrinho',
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
                itemCount: widget.itensCarrinhoList.length,
                itemBuilder: (BuildContext context, int i) {
                  return ItensCarrinho(
                    onDelete: () => _onDeleteItem(widget.itensCarrinhoList[i]['_id']),
                    idItemCarrinho: widget.itensCarrinhoList[i]['_id'],
                  
                    nomeProduto: widget.itensCarrinhoList[i]['produto']
                        ['nome'],
                    quantidade: widget.itensCarrinhoList[i]['quantidade'],
                    precoTotal: widget.itensCarrinhoList[i]['preco_total'],
                    adicionaisList: widget.itensCarrinhoList[i]
                        ['lista_ingredientes'],
                    imagem: widget.itensCarrinhoList[i]['produto']
                        ['imagem_produto'],
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PrimaryButton(
              title: "Continuar para pagamento",
              extraLarge: 0,
              onPressed: continueBuyCheckout,
            ),
          ),
        ],
      ),
    );
  }
}

class ItensCarrinho extends StatefulWidget {
  const ItensCarrinho(
      {super.key,
      required this.idItemCarrinho,
      required this.nomeProduto,
      required this.quantidade,
      required this.precoTotal,
      required this.adicionaisList,
      required this.imagem,
      required this.onDelete,
    });

  final String idItemCarrinho;
  final int quantidade;
  final String nomeProduto;
  final String precoTotal;
  final String imagem;
  final List<dynamic> adicionaisList;
  final VoidCallback onDelete;
  

  @override
  State<ItensCarrinho> createState() => _ItensCarrinhoState();
}

class _ItensCarrinhoState extends State<ItensCarrinho> {
  bool isLoading = true;

  Future<void> deletedItemCart(idItemCart) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/items-cart/delete-item-cart-by-id/$idItemCart');

    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        widget.onDelete();
        SnackBarUtils.showSnackBar(
          context, 'Item removido do carrinho!', color: Colors.red);
        isLoading = false; 
      });
    } else if (response.statusCode == 400)  {
      setState(() {
         SnackBarUtils.showSnackBar(
          context, 'Ocorreu um erro em remover o item do carrinho', color: Colors.red);
        isLoading = false; 
      });
    } else {
      setState(() {
        SnackBarUtils.showSnackBar(
          context, 'Erro ao remover o item do carrinho.', color: Colors.red);
        isLoading = false;
      });
    }
  }

  void removeItemCart(idItemCart) {
    deletedItemCart(idItemCart);
  }

  String formatToTwoDecimalPlaces(String value) {
    final number = double.parse(value);
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(number);
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${widget.quantidade}x'),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.nomeProduto,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text('R\$ ${formatToTwoDecimalPlaces(widget.precoTotal)}'),
                                    Container(
                                      width: 200, // Define a largura máxima disponível
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: widget.adicionaisList.length,
                                        itemBuilder: (BuildContext context, int i) {
                                          return SingleChildScrollView(
                                            child: Text(
                                              'Adicional: ${widget.adicionaisList[i]['nome']}',
                                              style: TextStyle(
                                                fontSize: 10
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => removeItemCart(widget.idItemCarrinho, ),
                                      child: Text(
                                        'Excluir', 
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  widget.imagem,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                color: Color.fromARGB(255, 199, 197, 197),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


