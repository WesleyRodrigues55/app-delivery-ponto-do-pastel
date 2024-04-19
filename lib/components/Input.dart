

import 'package:flutter/material.dart';

class InputCustom extends StatelessWidget {
  const InputCustom({ 
    super.key,
    required this.controllerName
  });

  final TextEditingController controllerName;

  
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerName,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
        border: InputBorder.none,
      ),
    );
  }
}