import 'dart:convert';

import 'package:app_delivery_ponto_do_pastel/components/PrimaryButton.dart';
import 'package:app_delivery_ponto_do_pastel/components/input.dart';
import 'package:app_delivery_ponto_do_pastel/utils/snack.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({super.key});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _whatsappController = TextEditingController();

  final RegExp regexDate = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  int _currentStep = 0;
  final bool _isVerticalStepper = true;

  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  _stepContinue() {
    _currentStep < 1 ? setState(() => _currentStep += 1) : null;
  }

  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

String convertDate(String data) {
  List<String> dateParts = data.split('/');
  int day = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int year = int.parse(dateParts[2]);

  DateTime date = DateTime(year, month, day);

  String isoDateString = date.toIso8601String();
  return isoDateString;
}

Future<bool> sendCodeVerification() async {
    var url = Uri.parse(
        'http://localhost:5000/api/auth/register-with-wpp');

    var headers = {'Content-Type': 'application/json'};
    var data = {
        "nome": _nomeController.text,
        "username": _whatsappController.text,
        "whatsapp": _whatsappController.text,
        "email": _whatsappController.text,
        "cpf": _cpfController.text,
        "data_nascimento": convertDate(_dataNascimentoController.text),
        "nivel": 1,
        "ativo": 1,
        "preferencia_notificacao": [
            "whatsapp"
        ],
        "termo_politicas": 1
    };

    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
        SnackBarUtils.showSnackBar(
          context, 'O usuário já existe na base de dados',
          color: Colors.red);
      return false;
    } else {
      SnackBarUtils.showSnackBar(
          context, 'Erro ao cadastarr o usuário',
          color: Colors.red);
      return false;
    }
  }
  
  void validaCampos() {
    if (formKey.currentState!.validate()) {
       sendCodeVerification().then((value) {
        if (value) {
          _nomeController.clear();
          _cpfController.clear();
          _dataNascimentoController.clear();
          _whatsappController.clear();

          SnackBarUtils.showSnackBar(context, 'Usuário cadastrado com sucesso!', color: Colors.green);
        } 
      });
    } else {
      SnackBarUtils.showSnackBar(context, 'Os campos precisam ser preenchidos');
    }
  }

  String? validateUsuario(value) {
    if (value == null || value.isEmpty) {
      return 'Digite a nome de Usuário!';
    }

    if (value.length < 2) {
      return 'Digite um nome Usuário válido';
    }
    return null;
  }

  String? validateCPF(value) {
    if (value == null || value.isEmpty) {
      return 'Digite a CPF!';
    }

    if (value.length < 10) {
      return 'Digite um CPF válido';
    }
    return null;
  }
  
  String? validateData(value) {
    if (value == null || value.isEmpty) {
      return 'Digite a data de nascimento';
    }
    RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!regex.hasMatch(value)) {
      return 'Digite a data no formato correto (dd/mm/yyyy)';
    }
    return null;
  }

  void changedValidadteData(value) {
    if (value != null && value.isNotEmpty) {
      if (value.length == 2 && !value.endsWith('/')) {
        value += '/';
      } else if (value.length == 5 && !value.endsWith('/')) {
        value += '/';
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 198, 6, 6),
        title: const Text('Cadastro do usuário',),
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
                          validation: (value) => validateUsuario(value,)
                        ),
                        InputCustom(
                          qtdLength: 11,
                          keyboardType: TextInputType.number,
                          label: "CPF",
                          placeholder: "Digite o seu CPF, somente números!",
                          controllerName: _cpfController,
                          validation: (value) => validateCPF(value),
                        ),
                        InputCustom(
                          qtdLength: 10,
                          keyboardType: TextInputType.datetime,
                          label: 'Data de Nascimento',
                          placeholder: 'Exemplo: 27/01/1999',
                          controllerName: _dataNascimentoController,
                          validation: (value) => validateData(value),
                          onChanged: (value) {
                            changedValidadteData(value);
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
                          qtdLength: 12,
                          keyboardType: TextInputType.number,
                          label: "Digite seu número de wpp com o DDD (somente números)",
                          placeholder: "Digite seu número de wpp com o DDD (somente números)",
                          controllerName: _whatsappController,
                          validation: (whatsapp) {
                            if (whatsapp == null || whatsapp.isEmpty) {
                              return "Informe o número de celular";
                            } else if (whatsapp.length < 11) {
                              // Considerando os parênteses e o traço
                              return "O número de celular deve conter 12 dígitos";
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
                ],
              ),
            ),
            PrimaryButton(
              title: 'Cadastrar',
              extraLarge: 2,
              onPressed: () {
                validaCampos();
              },
            ),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
