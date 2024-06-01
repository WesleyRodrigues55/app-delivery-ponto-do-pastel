import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/pages/Home.dart';
import 'package:flutter/material.dart';

class OrdersEmpty extends StatelessWidget {
  const OrdersEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://raw.githubusercontent.com/WesleyRodrigues55/app-delivery-ponto-do-pastel/main/img/checklist.png",
            height: 180,
          ),
          SizedBox(height: 20,),
          Text("Não há pedidos por aqui...",),
          PrimaryButton(
            title: "Comece a comprar agora!", 
            extraLarge: 0, 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}