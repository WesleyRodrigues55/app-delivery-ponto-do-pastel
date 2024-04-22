import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/pages/home.dart';

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
        const Padding(padding: EdgeInsets.all(20)),
        ListTile(
          title: Text(
            nomeProduto,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                descricaoProduto,
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Preço: R\$${precoProduto}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ],
          ),
          trailing: Image(
            image: NetworkImage(imageProduto),
            width: 200,
            height: 150,
          ),
          onTap: onTap,
          minVerticalPadding: 50,
        ),
        // SizedBox(height: 10),
        const Divider(
          height: 10,
        ),
      ],
    );
  }
}
