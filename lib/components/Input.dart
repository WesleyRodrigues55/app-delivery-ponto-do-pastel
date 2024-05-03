import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustom extends StatelessWidget {
  const InputCustom({
    super.key,
    required this.controllerName,
    required this.label,
    required this.placeholder,
    required this.keyboardType,
    this.validation,
    this.obscureText,
    this.onChanged,
  });

  final String label;
  final String placeholder;
  final TextEditingController controllerName;
  final bool? obscureText;
  final String? Function(String?)? validation;
  final String? Function(String?)? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        TextFormField(
          keyboardType: keyboardType,
          controller: controllerName,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            hintText: placeholder,
          ),
          validator: validation,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
