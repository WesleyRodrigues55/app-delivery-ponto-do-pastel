import 'package:flutter/material.dart';

class ProdutoSelecionado extends StatefulWidget {
  const ProdutoSelecionado({super.key});

  @override
  State<ProdutoSelecionado> createState() => _ProdutoSelecionadoState();
}

class _ProdutoSelecionadoState extends State<ProdutoSelecionado> {
  final List<bool> _checkboxes = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                Image.asset('img/produtos/pastel-carne.png'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Pastel de Carne',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Massa crocante, recheada com uma carne suculenta e temperadinha, ovo e azeitonas picadas",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Preço: R\$",
                            textAlign: TextAlign.left,
                            style: TextStyle(
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
                          const TextField(
                            decoration: InputDecoration(
                              labelText: "Observação",
                              hintText:
                                  "Caso tenha alguma observação sobre seu pedido, escreva aqui para nós =)",
                              border: OutlineInputBorder(),
                            ),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
