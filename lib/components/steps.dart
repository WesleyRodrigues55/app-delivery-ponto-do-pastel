import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int totalSteps;
  final int activeStep;

  const StepIndicator({
    required this.totalSteps,
    required this.activeStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < totalSteps; i++)
          _buildStepIndicator(i == activeStep),
      ],
    );
  }

  Widget _buildStepIndicator(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 15, // Definindo a largura desejada
      height: 15, // Definindo a altura desejada
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.red : Colors.grey,
      ),
    );
  }
}
