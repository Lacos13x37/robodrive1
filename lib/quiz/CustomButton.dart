import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback method;
  final String text;
  const CustomButton(
      {Key? key, required this.text, required this.method})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: method,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
