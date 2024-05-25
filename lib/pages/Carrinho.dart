import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:app_delivery_ponto_do_pastel/components/myDrawer.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Pagamento.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

List<String> list = ['Selecione', 'PIX'];

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
    var headers = {'Authorization': 'Bearer $token'};
    print('Fetching user with token: $token');
    String? userId = sharedPreferences.getString('userId');
    var url = Uri.parse(
        'https://backend-delivery-ponto-do-pastel.onrender.com/api/cart/get-cart-open-with-items-cart/$userId');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        itensCarrinho = data['results'];
        print(data['results']);
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
    } else if (itensCarrinho.isEmpty) {
      // Dados carregados, mas a lista de produtos está vazia
      return const Center(
        child: Text('Nenhum produto encontrado'),
      );
    } else {
      //Dados carregados e há produtos na lista
      return ListView.builder(
        itemCount: itensCarrinho.length,
        itemBuilder: (BuildContext context, int i) {
          return SingleChildScrollView(
            child: CarrinhoBuilder(
              enderecoUsuarioList: itensCarrinho[i]['endereco_usuario'],
              itensCarrinhoList: itensCarrinho[i]['itens_carrinho'],
              taxaFixa: itensCarrinho[i]['taxa_fixa'],
              valorTotalComTaxa: itensCarrinho[i]['valor_total_com_taxa'],
              valorTotalCompra: itensCarrinho[i]['valor_total_compra'],
            ),
          );
        },
      );
    }
  }
}

class CarrinhoBuilder extends StatefulWidget {
  const CarrinhoBuilder(
      {super.key,
      required this.itensCarrinhoList,
      required this.enderecoUsuarioList,
      required this.taxaFixa,
      required this.valorTotalComTaxa,
      required this.valorTotalCompra});

  final String taxaFixa;
  final String valorTotalComTaxa;
  final String valorTotalCompra;
  final List<dynamic> itensCarrinhoList;
  final List<dynamic> enderecoUsuarioList;

  @override
  State<CarrinhoBuilder> createState() => _CarrinhoBuilderState();
}

class _CarrinhoBuilderState extends State<CarrinhoBuilder> {
  int _currentIndex = 0;
  String dropdownValue = list.first;
  final formKey = GlobalKey<FormState>();  

  void validarBotao() {
    if (dropdownValue != 'Selecione') {
      print('Funcionou');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Pagamento(),
        ),
      );
    } else {
      SnackBarUtils.showSnackBar(context, 'Os campos precisam ser preenchidos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Itens Carrinho',
                          style: TextStyle(
                            fontFamily: 'OutFIT',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.itensCarrinhoList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ItensCarrinho(
                        nomeProduto: widget.itensCarrinhoList[i]['produto']
                            ['nome'],
                        quantidade: widget.itensCarrinhoList[i]['quantidade'],
                        precoTotal: widget.itensCarrinhoList[i]['preco_total'],
                        adicionaisList: widget.itensCarrinhoList[i]
                            ['lista_ingredientes'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PrimaryButton(
              title: "+ Continuar Comprando",
              extraLarge: 0,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                )
              },
            ),
          ),
          Container(
            color: Color.fromARGB(255, 231, 231, 231),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: TextStyle(fontSize: 14)),
                      Text('R\$ ${widget.valorTotalCompra}',
                          style: TextStyle(fontSize: 14))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Taxa Fixa de Entrega',
                          style: TextStyle(fontSize: 14)),
                      Text('R\$ ${widget.taxaFixa}',
                          style: TextStyle(fontSize: 14))
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
                      Text('TOTAL',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('R\$ ${widget.valorTotalComTaxa}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'O pedido mínimo desse restaurante para entrega é de R\$ 10,00, sem contar a taxa de entrega',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EnderecoUsuario(),
                  Row(
                    children: [
                      Text(
                        'Pagamento',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Outfit'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Escolha a Forma de Pagamento:',
                        style: TextStyle(fontSize: 14),
                      ),
                      DropdownButton(
                        value: dropdownValue,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 1,
                          color: Colors.red,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              PrimaryButton(
                title: "Finalizar Pedido",
                extraLarge: 0,
                textColor: Colors.black,
                bgButton: Color.fromARGB(255, 199, 197, 197),
                onPressed: () => {validarBotao()},
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ItensCarrinho extends StatelessWidget {
  const ItensCarrinho(
      {super.key,
      required this.nomeProduto,
      required this.quantidade,
      required this.precoTotal,
      required this.adicionaisList});
  final int quantidade;
  final String nomeProduto;
  final String precoTotal;
  final List<dynamic> adicionaisList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Text(
                  '${quantidade}x',
                  style: TextStyle(fontSize: 20),
                ),
                title: Text(nomeProduto),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('R\$ ${precoTotal}'),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: adicionaisList.length,
                      itemBuilder: (BuildContext context, int i) {
                        return SingleChildScrollView(
                          child: Text(
                            'Adicional: ${adicionaisList[i]['nome']}',
                          ),
                        );
                      },
                    ),
                  ],
                ),
                trailing: Image.network(
                    'https://images.pexels.com/photos/2233442/pexels-photo-2233442.jpeg'),
              ),
              TextButton(onPressed: () {}, child: Text('Remover')),
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

class EnderecoUsuario extends StatefulWidget {
  const EnderecoUsuario({super.key});
   
  @override
  State<EnderecoUsuario> createState() => _EnderecoUsuarioState();
}

class _EnderecoUsuarioState extends State<EnderecoUsuario> {
  final formKey = GlobalKey<FormState>();
  final controllerRua = TextEditingController();
  final controllerNumero = TextEditingController();
  final controllerBairro = TextEditingController();
  final controllerReferencia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Endereço de Entrega',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Outfit'),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Form(
            key: formKey,
            child: Column(children: [
              InputCustom(
                controllerName: controllerRua,
                label: 'Rua',
                placeholder: 'Rua',
                keyboardType: TextInputType.text,
                validation: (value) {
                  if (value == null || value.length < 5) {
                    return 'Digite uma Rua válida.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              InputCustom(
                controllerName: controllerNumero,
                label: 'Número',
                placeholder: 'Número',
                keyboardType: TextInputType.number,
                validation: (value) {
                  if (value == null || value.length < 1) {
                    return 'Digite um Número válido.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              InputCustom(
                controllerName: controllerBairro,
                label: 'Bairro',
                placeholder: 'Bairro',
                keyboardType: TextInputType.text,
                validation: (value) {
                  if (value == null || value.length < 5) {
                    return 'Digite um Bairro válido.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              InputCustom(
                controllerName: controllerReferencia,
                label: 'Referência',
                placeholder: 'Referência',
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),
            ])),
      ],
    );
  }
}
