import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({
    super.key, 
    required this.imagePath
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 219, 239, 255),
      ),
      child: Image.asset(imagePath,height: 30,),
    );
  }
}
