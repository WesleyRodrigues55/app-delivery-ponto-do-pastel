import 'package:flutter/material.dart';

class Cardapio extends StatelessWidget {
  const Cardapio(
      {super.key,
      required this.imageProduto,
      required this.descricaoProduto,
      required this.nomeProduto,
      required this.precoProduto,
      required this.onTap});

  final String imageProduto;
  final String nomeProduto;
  final String precoProduto;
  final String descricaoProduto;
  final void Function()? onTap;

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
                        ),
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
