import 'package:app_delivery_ponto_do_pastel/components/input.dart';
import 'package:app_delivery_ponto_do_pastel/components/primaryButton.dart';
import 'package:flutter/material.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({super.key});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final formKey = GlobalKey<FormState>();

  int _currentStep = 0;
  bool _isVerticalStepper = true;

  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  _stepContinue() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
  }

  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro do usuário'),
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
                  // The first step: Name
                  Step(
                    title: const Text('Name'),
                    content: Column(
                      children: [
                        InputCustom(controllerName: TextEditingController(), label: "USername", placeholder: "username"),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  // The second step: Phone number
                  Step(
                    title: const Text('Phone'),
                    content: Column(
                      children: [
                        InputCustom(controllerName: TextEditingController(), label: "USername", placeholder: "username"),
                        InputCustom(controllerName: TextEditingController(), label: "USername", placeholder: "username"),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  // The third step: Verify phone number
                  Step(
                    title: const Text('Verify'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Verification code'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: const Text('Verify'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Verification code'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
