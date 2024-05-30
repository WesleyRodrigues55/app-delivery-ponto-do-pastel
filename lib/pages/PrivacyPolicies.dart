import 'package:flutter/material.dart';

class PrivacyPolicies extends StatefulWidget {
  const PrivacyPolicies({super.key});

  @override
  State<PrivacyPolicies> createState() => _PrivacyPoliciesState();
}

class _PrivacyPoliciesState extends State<PrivacyPolicies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Políticas de Privacidade"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "NOTA: Esse app faz parte de um projeto de alunos da Universidade de Sorocaba, portanto toda a política abaixo é fictícia, bem como os dados informados.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "Nós utilizamos os seus dados como parte da nossa missão de proporcionar um serviço cada vez melhor. Essa política descreve como obtemos, armazenamos, utilizamos e compartilhamos as suas informações.\n\nA proteção dos seus dados e da sua privacidade são muito importantes para nós. Portanto, recomendamos que você conheça melhor as nossas práticas e, em caso de dúvidas, entre em contato conosco.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                "Nosso objetivo é fornecer nossos produtos e serviço, garantindo a sua privacidade e protegendo os seus dados, conforme explicado nessa Política de Privacidade. Caso você não concorde com nossas práticas solicitamos que não utilize dessa plataforma.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "1 - Quem é o controlador de seus dados pessoais?\n",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(
                "O PONTO DO PASTEL COMÉRCIO DE ALIMENTOS - ME, inscrita no CNPJ de nº 00.000.000/0000-00, situada na Rod. Raposo Tavares, km 92,5 - Vila Artura, na cidade de Sorocaba/SP, é a empresa controladora dos dados pessoais tratados no âmbito desta Política de Privacidade.\n\nPara fins da legislação aplicável, controlador é a quem compete as decisões referentes ao tratamento de dados pessoais. Nos termos da Lei Geral de Proteção de Dados Pessoais (Lei n. 13.709/18 ou LGPD), a empresa é responsável apenas pelas atividades de tratamento de dados pessoais dos titulares cadastrados nesse aplicativo (conforme definido abaixo).\n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "2 - Quais tipos de informações coletamos?\n",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(
                "Ao utilizar o app nós coletamos algumas informações importantes para que possamos prestar um serviço adequado para você.\n\na. Informações pessoais\n\nQuando você se cadastra para ser um usuário registrado, solicitamos informações sobre você, tais como: nome, data de nascimento, CPF e número de telefone.\n\nb. Informações de pagamento\n\nAo fazer o seu pedido o pagamento é feito diretamente no nosso aplicativo. Para isso você irá nos fornecer os seus dados do seu cartão de crédito. Nós usamos esses dados para poder confirmar a sua ordem de pagamento e garantir que não ocorram fraudes por meio dos nossos Serviços.\n\nc. Informações de localização\n\nPara poder realizar a entrega do seu pedido, nós precisamos que você também nos informe a sua localização ou a localização do local em que gostaria que entregássemos o seu pedido. Essa localização pode ser fornecida pelo endereço que você inserir manualmente no aplicativo e confirmada por você. Para fins da lei n° 12.965 de 2014 (Marco Civil da Internet), ou qualquer lei que venha substituí-la, a localização fornecida será considerada como dado cadastral.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "3 - Como utilizamos essas informações?\n",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(
                "a. Promover, melhorar e desenvolver nossos serviços\n\nPodemos usar essas informações coletadas para nos ajudar a desenvolver, oferecer e melhorar os nossos produtos destinados a você, existentes ou a serem criados.Também poderemos usar suas informações pessoais para fins internos, tais como auditoria, análise de dados e pesquisas para aprimorar os produtos, geração de análises estatísticas com respeito ao uso dos nossos serviços, incluindo tendências de consumo.\n\nb. Comunicação\n\nPeriodicamente poderemos usar suas informações pessoais para enviar avisos e notificações importantes, como comunicados sobre compras, alterações em prazos, condições e políticas.\n\nc. Segurança\n\nNós podemos também utilizar esses dados coletados para aprimorar a segurança e melhorar os serviços e as ofertas do app destinadas a você. Dessa forma, podemos analisar e solucionar problemas técnicos, bem como identificar e coibir fraudes na utilização do nosso Serviço.\n\nd. Promoções\n\nSe você participar de qualquer outra modalidade de promoção, poderemos usar as informações que você fornecer para administrar esses programas.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "4 - Proteção de dados pessoais\n",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(
                "A PONTO DO PASTEL COMÉRCIO DE ALIMENTOS - ME utiliza medidas técnicas e organizacionais apropriadas para proteger seus dados pessoais contra tratamento desautorizado ou ilegal e contra perda acidental, destruição ou danos. Seus dados pessoais são armazenados de maneira segura em equipamentos protegidos. Apenas um número limitado de pessoas terá acesso a tais equipamentos e apenas indivíduos com motivos legítimos terão acesso a seus dados pessoais.\n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                "Se tiver qualquer dúvida em relação à essa Política de Privacidade ou a respeito de como tratamos os seus dados, poderá entrar em contato através do nosso e-mail para esclarecimentos: app.pontodopastel@gmail.com \n",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
