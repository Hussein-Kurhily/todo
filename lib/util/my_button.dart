import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Icon icon ;

  const MyButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,

        icon: icon
    );
  }
}
