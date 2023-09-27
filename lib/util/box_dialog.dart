import 'package:flutter/material.dart';
import '../util/my_button.dart';

class CustomBoxDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CustomBoxDialog({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,

  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text(
        'Create New Task',
        textAlign: TextAlign.center,
        style:  TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.deepPurple[100],

      content: Container(
        height: 180,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
            const Spacer(
              flex: 1,
            ),
            // some button like => save + cancel
            Row(
              children: [
                MyButton(
                  icon: const Icon(Icons.check),
                  onPressed: onSave,
                ),
                const Spacer(
                  flex: 1,
                ),
                MyButton(
                  icon: const Icon(Icons.close),
                  onPressed: onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
