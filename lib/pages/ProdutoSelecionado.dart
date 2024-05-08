import 'package:app_delivery_ponto_do_pastel/components/ProdutoSelecionadoPorId.dart';
import 'package:flutter/material.dart';

class ProdutoSelecionado extends StatefulWidget {
  const ProdutoSelecionado({super.key});

  @override
  State<ProdutoSelecionado> createState() => _ProdutoSelecionadoState();
}

class _ProdutoSelecionadoState extends State<ProdutoSelecionado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Produto Selecionado")),
      body: const ProdutoSelecionadoPorId(),
    );
  }
}
