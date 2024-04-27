import 'package:flutter/material.dart';
import 'package:app_delivery_ponto_do_pastel/components/input.dart';
import 'package:app_delivery_ponto_do_pastel/components/primaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:app_delivery_ponto_do_pastel/components/steps.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _cpfController = TextEditingController();
  int activeStep = 0;

  void validaCampos() {
    if (formKey.currentState!.validate()) {
      SnackBarUtils.showSnackBar(context, 'Formulário enviado');
    } else {
      SnackBarUtils.showSnackBar(context, 'Os campos precisam ser preenchidos');
    }
  }

  void _proximoPasso() {
    setState(() {
      if (activeStep < 3) {
        activeStep++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 198, 6, 6),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            alignment: Alignment.topLeft,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (activeStep == 0) ...[
                      // Primeira "tela"
                      const Text(
                        'Crie sua Conta',
                        style: TextStyle(
                          color: Color.fromRGBO(132, 147, 172, 1),
                          fontFamily: 'OutFIT',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      InputCustom(
                        label: 'Digite seu nome completo',
                        placeholder: 'Exemplo: Wesley Dos Santos da Silva',
                        controllerName: _nomeController,
                        validation: (value) {
                          if (value == null || value.length < 5) {
                            return 'Digite um nome de usuário válido!';
                          }
                          return null;
                        },
                      ),
                      InputCustom(
                        label: 'Data de Nascimento',
                        placeholder: 'Exemplo: 27/01/1999',
                        controllerName: _dataNascimentoController,
                        validation: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Digite a data de nascimento';
                          // }
                          // RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                          // if (!regex.hasMatch(value)) {
                          //   return 'Digite a data no formato correto (dd/mm/yyyy)';
                          // }
                          return null;
                        },
                        onChanged: (value) {
                          if (value!.isNotEmpty) {
                            // Aplica a máscara enquanto o usuário digita
                            // if (!regexDate.hasMatch(value)) {
                            //   String maskedValue = '';
                            //   for (int i = 0; i < value.length; i++) {
                            //     if (i == 2 || i == 5) {
                            //       maskedValue += '/';
                            //     }
                            //     maskedValue += value[i];
                            //   }
                            //   setState(() {
                            //     _dataNascimentoController.value =
                            //         TextEditingValue(
                            //       text: maskedValue,
                            //       selection: TextSelection.collapsed(
                            //         offset: maskedValue.length,
                            //       ),
                            //     );
                            //   });
                            // }
                          }
                        },
                      ),
                      InputCustom(
                        label: 'CPF',
                        placeholder: 'xxx.xxx.xxx-xx',
                        controllerName: _cpfController,
                        validation: (value) {
                          if (value == null || value.length < 30) {
                            return 'Digite o seu CPF';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      PrimaryButton(
                        onPressed: _proximoPasso,
                        title: 'Continuar',
                        extraLarge: 2,
                      ),
                    ] else if (activeStep == 1) ...[
                      // Segunda "tela"
                      StepIndicator(totalSteps: 4, activeStep: activeStep),
                      SizedBox(height: 20),
                      Container(
                        child: Center(
                          child: Text('Essa é a segunda tela'),
                        ),
                      ),
                      PrimaryButton(
                        onPressed: _proximoPasso,
                        title: 'Continuar',
                        extraLarge: 2,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
