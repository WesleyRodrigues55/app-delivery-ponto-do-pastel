import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/components/input.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({super.key});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _whatsappCodController = TextEditingController();

  final RegExp regexDate = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  int _currentStep = 0;
  final bool _isVerticalStepper = true;

  void validaCampos() {
    if (formKey.currentState!.validate()) {
      SnackBarUtils.showSnackBar(context, 'Formulário enviado');
    } else {
      SnackBarUtils.showSnackBar(context, 'Os campos precisam ser preenchidos');
    }
  }

  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  _stepContinue() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 198, 6, 6),
        title: Text(
          'Cadastro do usuário',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit'),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: _isVerticalStepper
                    ? StepperType.vertical
                    : StepperType.horizontal,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => _stepTapped(step),
                onStepContinue: _stepContinue,
                onStepCancel: _stepCancel,
                steps: [
                  Step(
                    title: const Text('Dados pessoais',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 15.0,
                        )),
                    content: Column(
                      children: [
                        InputCustom(
                          keyboardType: TextInputType.name,
                          label: "Nome do usuário",
                          placeholder: "Digite o seu nome completo",
                          controllerName: _nomeController,
                          validation: (name) => name!.length < 3
                              ? 'Necessário ter pelo menos 3 letras'
                              : null,
                        ),
                        InputCustom(
                          keyboardType: TextInputType.name,
                          label: "CPF",
                          placeholder: "Digite o seu CPF",
                          controllerName: _cpfController,
                        ),
                        InputCustom(
                          keyboardType: TextInputType.datetime,
                          label: 'Data de Nascimento',
                          placeholder: 'Exemplo: 27/01/1999',
                          controllerName: _dataNascimentoController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite a data de nascimento';
                            }
                            RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                            if (!regex.hasMatch(value)) {
                              return 'Digite a data no formato correto (dd/mm/yyyy)';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value != null && value.isNotEmpty) {
                              if (value.length == 2 && !value.endsWith('/')) {
                                // Adiciona uma barra após o dia
                                value += '/';
                              } else if (value.length == 5 &&
                                  value.indexOf('/') != 2) {
                                // Adiciona uma barra após o mês, somente se o dia já foi digitado
                                value = value.replaceRange(2, 3, '/');
                              } else if (value.length == 10 &&
                                  value.lastIndexOf('/') != 5) {
                                // Adiciona uma barra após o ano, somente se o dia e o mês já foram digitados
                                value = value.replaceRange(5, 6, '/');
                              }
                              setState(() {
                                _dataNascimentoController.value =
                                    TextEditingValue(
                                  text: value!,
                                  selection: TextSelection.collapsed(
                                      offset: value.length),
                                );
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('WhatsApp',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 15.0,
                        )),
                    content: Column(
                      children: [
                        InputCustom(
                          keyboardType: TextInputType.number,
                          label: "Digite o seu número WhatsApp",
                          placeholder: "(DD)XXXXX-XXXX",
                          controllerName: _whatsappController,
                          validation: (whatsapp) {
                            if (whatsapp == null || whatsapp.isEmpty) {
                              return "Informe o número de celular";
                            } else if (whatsapp.length != 13) {
                              // Considerando os parênteses e o traço
                              return "O número de celular deve conter 13 dígitos";
                            } else if (!RegExp(r'^\(\d{2}\)\d{5}-\d{4}$')
                                .hasMatch(whatsapp)) {
                              return "Formato inválido. Use (DD)XXXXX-XXXX";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Verificação',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 15.0,
                        )),
                    content: Column(
                      children: [
                        InputCustom(
                          keyboardType: TextInputType.number,
                          label: "Digite o Código recebido",
                          placeholder:
                              "Digite o código de 5 números recebido em seu WhatsApp",
                          controllerName: _whatsappCodController,
                          validation: (value) {
                            return null;
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
            PrimaryButton(
              title: 'Ir para Tela de Login',
              extraLarge: 2,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  'Formulário é valido';
                  // Insira aqui o código para navegar para a tela de login
                  Navigator.pushNamed(context, '/login');
                } else {
                  'O formulário não é valido!';
                }
              },
            ),
            SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}