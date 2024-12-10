import 'package:exercise2_app/pages/components/mybuttons.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  // TextEditingController controller = TextEditingController();

  final controller;

  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add a new task Yoo..',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                    name: ' Save',
                    color: Color.fromARGB(255, 126, 240, 139),
                    onPressed: onSave),
                // const SizedBox(
                //   width: 5,
                // ),
                MyButton(
                    name: 'Cancel',
                    color: const Color.fromARGB(255, 240, 134, 126),
                    onPressed: onCancel),
              ],
            )
          ],
        ),
        height: 140,
        width: 300,
      ),
    );
  }
}
