import 'package:flutter/material.dart';

class FrequentlyAskedQuestions extends StatefulWidget {
  const FrequentlyAskedQuestions({super.key});

  @override
  State<FrequentlyAskedQuestions> createState() =>
      _FrequentlyAskedQuestionsState();
}

class _FrequentlyAskedQuestionsState extends State<FrequentlyAskedQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perguntas Frequentes"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                ExpansionTile(
                  title: Text(
                    '1 - Como faço para criar uma conta?',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.account_box,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                  backgroundColor: Color.fromARGB(255, 199, 199, 199),
                  collapsedBackgroundColor: Color.fromARGB(255, 185, 184, 184),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: <Widget>[
                    Text(
                      "Para criar uma conta, clique no botão 'Cadastre-se' abaixo do campo celular da página inicial. Insira suas informações pessoais, como nome, CPF, data de nascimento e telefone, e siga as instruções para concluir o cadastro.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                ExpansionTile(
                  title: Text(
                    '2 - Como faço para fazer um pedido?',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.fastfood_rounded,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                  backgroundColor: Color.fromARGB(255, 199, 199, 199),
                  collapsedBackgroundColor: Color.fromARGB(255, 185, 184, 184),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: <Widget>[
                    Text(
                      "1. Faça login na sua conta.\n2. Selecione os itens que deseja e adicione-os ao carrinho.\n3. Revise seu pedido no carrinho de compras.\n4. Insira seu endereço para entrada.\n5. Escolha a forma de pagamento e finalize o pedido.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                ExpansionTile(
                  title: Text(
                    '3 - Quais formas de pagamentos são aceitas?',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.payment_rounded,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                  backgroundColor: Color.fromARGB(255, 199, 199, 199),
                  collapsedBackgroundColor: Color.fromARGB(255, 185, 184, 184),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: <Widget>[
                    Text(
                      "O método de pagamento aceito até o momento nesta plataforma é somente o PIX",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                ExpansionTile(
                  title: Text(
                    '4 - Há taxas adicionais para a entrega?',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.delivery_dining_rounded,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                  backgroundColor: Color.fromARGB(255, 199, 199, 199),
                  collapsedBackgroundColor: Color.fromARGB(255, 185, 184, 184),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: <Widget>[
                    Text(
                      "Sim, a taxa de entrega fixa de nossa plataforma é de 10,00",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                ExpansionTile(
                  title: Text(
                    '5 - Como posso entrar em contato com o suporte ao cliente?',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.contact_mail_rounded,
                    color: Colors.black,
                  ),
                  trailing: Icon(
                    Icons.expand_more,
                    color: Colors.black,
                  ),
                  backgroundColor: Color.fromARGB(255, 199, 199, 199),
                  collapsedBackgroundColor: Color.fromARGB(255, 185, 184, 184),
                  childrenPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: <Widget>[
                    Text(
                      "Você pode entrar em contato com nosso suporte ao cliente através do chat disponível no site e no aplicativo, ou enviando um e-mail para app.pontodopastel@gmail.com",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10.0),
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
