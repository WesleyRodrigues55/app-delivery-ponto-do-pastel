import 'dart:convert';
import 'package:app_delivery_ponto_do_pastel/components/CartEmpty.dart';
import 'package:app_delivery_ponto_do_pastel/components/Input.dart';
import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Pagamento.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

List<String> list = ['Selecione', 'PIX'];

class CheckoutCompra extends StatefulWidget {
  const CheckoutCompra({super.key});


  @override
  State<CheckoutCompra> createState() => _CheckoutCompraState();
}

class _CheckoutCompraState extends State<CheckoutCompra> {
  bool isLoading = true;
  List<dynamic> itensCarrinho = [];
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var idCarrinho = ModalRoute.of(context)?.settings.arguments as String?;
  }

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
        isLoading = false;
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutCompra(),
        ),
      );
      return Text('');
    } else {
      if (itensCarrinho[0]['itens_carrinho'].isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckoutCompra(),
          ),
        );
          return Text('');
      }

      return Scaffold(
        appBar: AppBar(title: const Text("Checkout Compra"),),
        body: ListView.builder(
          itemCount: itensCarrinho.length,
          itemBuilder: (BuildContext context, int i) {
            return SingleChildScrollView(
                child: FormCheckoutCompra(
                  enderecoUsuarioList: itensCarrinho[i]['endereco_usuario'],
                  itensCarrinhoList: itensCarrinho[i]['itens_carrinho'],
                  taxaFixa: itensCarrinho[i]['taxa_fixa'],
                  valorTotalComTaxa: itensCarrinho[i]['valor_total_com_taxa'],
                  valorTotalCompra: itensCarrinho[i]['valor_total_compra'],
              ), 
            );
          },
        )
      );
      
    }
  }
}

class FormCheckoutCompra extends StatefulWidget {
  FormCheckoutCompra({
    super.key,
    required this.taxaFixa,
    required this.valorTotalComTaxa,
    required this.valorTotalCompra,
    required this.itensCarrinhoList,
    required this.enderecoUsuarioList,
  });

  final String? taxaFixa;
  final String? valorTotalComTaxa;
  final String? valorTotalCompra;
  final List<dynamic>? itensCarrinhoList;
  final List<dynamic>? enderecoUsuarioList;

  @override
  State<FormCheckoutCompra> createState() => _FormCheckoutCompraState();
}

class _FormCheckoutCompraState extends State<FormCheckoutCompra> {
  final formKey = GlobalKey<FormState>();
  final controllerRua = TextEditingController();
  final controllerNumero = TextEditingController();
  final controllerBairro = TextEditingController();
  final controllerReferencia = TextEditingController();

  String dropdownValue = list.first;
  
  void validarBotao() {
    if (dropdownValue != 'Selecione' && formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Pagamento(),
        ),
      );
    } else {
      SnackBarUtils.showSnackBar(context, 'Os campos precisam ser preenchidos', color: Colors.red);
    }
  }
  
  String formatToTwoDecimalPlaces(String value) {
    final number = double.parse(value);
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EnderecoUsuario(
                      enderecoUsuarioList: widget.enderecoUsuarioList!,
                      controllerRua: controllerRua,
                      controllerNumero: controllerNumero,
                      controllerBairro: controllerBairro,
                      controllerReferencia: controllerReferencia,
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Pagamento',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit'),
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
                        Text('R\$ ${formatToTwoDecimalPlaces(widget.valorTotalCompra!)}',
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
                        Text('R\$ ${formatToTwoDecimalPlaces(widget.taxaFixa!)}',
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
                        Text('R\$ ${formatToTwoDecimalPlaces(widget.valorTotalComTaxa!)}',
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
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        PrimaryButton(
                          title: "Finalizar Pedido",
                          extraLarge: 1,
                          bgButton: Colors.black,
                          onPressed: validarBotao,
                        ),
                      ],
                    ), 
                  ],
                ),
              ),
            ),
            
          ],
        ),
      );
  }
}

class EnderecoUsuario extends StatefulWidget {
  const EnderecoUsuario({
    super.key,
    required this.enderecoUsuarioList,
    required this.controllerRua,
    required this.controllerNumero,
    required this.controllerBairro,
    required this.controllerReferencia,
  });

  final List<dynamic> enderecoUsuarioList;
  final TextEditingController? controllerRua;
  final TextEditingController? controllerNumero;
  final TextEditingController? controllerBairro;
  final TextEditingController? controllerReferencia;

  @override
  State<EnderecoUsuario> createState() => _EnderecoUsuarioState();
}

class _EnderecoUsuarioState extends State<EnderecoUsuario> {
  
  @override
  void initState() {
    super.initState();
    if (widget.enderecoUsuarioList.isNotEmpty) {
      widget.controllerRua!.text = widget.enderecoUsuarioList[0]['rua'];
      widget.controllerBairro!.text = widget.enderecoUsuarioList[0]['bairro'];
      widget.controllerNumero!.text = widget.enderecoUsuarioList[0]['numero'];
      widget.controllerReferencia!.text = widget.enderecoUsuarioList[0]['complemento'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
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
        Column(children: [
          InputCustom(
            controllerName: widget.controllerRua!,
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
            controllerName: widget.controllerNumero!,
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
            controllerName: widget.controllerBairro!,
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
            controllerName: widget.controllerReferencia!,
            label: 'Referência',
            placeholder: 'Referência',
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      ],
    );
  }
}