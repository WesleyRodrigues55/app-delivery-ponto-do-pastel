import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    required this.title,
    required this.extraLarge,
    this.bgButton,
    this.textColor,
    this.route,
  });

  final String title;
  final int extraLarge;   // 1 = width 100% / 0 = % of content
  Color? bgButton;
  Color? textColor;
  String? route;

  @override
  Widget build(BuildContext context) {
    return extraLarge == 1 ? Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Expanded (
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, route ?? '/');
                },
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                  backgroundColor: MaterialStatePropertyAll(bgButton ?? const Color.fromARGB(255, 198, 6, 6)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), // Define o raio da borda
                      // Pode ajustar o raio conforme necessário
                    ),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor ?? Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ) : Column(
      children: [
        SizedBox(height: 10),
        TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, route ?? '/');
                },
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                  backgroundColor: MaterialStatePropertyAll(bgButton ?? const Color.fromARGB(255, 198, 6, 6)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4), // Define o raio da borda
                      // Pode ajustar o raio conforme necessário
                    ),
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor ?? Colors.white
                  ),
                ),
              ),
      ],
    );
  }
}