import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:flutter/material.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/cart-empty.png",
            height: 240,
          ),
          Text('Seu carrinho está vazio!'),
          Text('Comece a comprar clicando no botão abaixo.'),
          PrimaryButton(
            title: "Ver cardápio", 
            extraLarge: 0, 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            }
          )
        ],
      ),
    );
  }
}