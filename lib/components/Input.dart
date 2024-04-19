import 'package:flutter/material.dart';

class InputCustom extends StatelessWidget {
  const InputCustom({ 
    super.key,
    required this.controllerName,
    required this.label,
    required this.placeholder,
    this.validation,
    this.obscureText,
  });

  final String label;
  final String placeholder;
  final TextEditingController controllerName;
  final bool? obscureText;
  final String? Function(String?)? validation;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        TextFormField(
          controller: controllerName,
          obscureText: obscureText ?? false,
          decoration:  InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            hintText: placeholder,
          ),
          validator: validation,
        ),
      ],
    );
  }
}