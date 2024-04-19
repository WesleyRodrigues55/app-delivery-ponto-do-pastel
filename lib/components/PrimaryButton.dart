import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    required this.title,
    required this.extraLarge,
    // required this.route,
    required this.onPressed,
    this.bgButton,
    this.textColor,
  });

  final String title;
  final int extraLarge;   // 1 = width 100% / 0 = % of content
  final Color? bgButton;
  final Color? textColor;
  // final String? route;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return extraLarge == 1 ? Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Expanded (
              child: TextButton(
                // onPressed: (){
                //   Navigator.pushNamed(context, route ?? '');
                // },
                onPressed: onPressed,
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
                // onPressed: (){
                //   Navigator.pushNamed(context, route ?? '/');
                // },
                onPressed: onPressed,
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