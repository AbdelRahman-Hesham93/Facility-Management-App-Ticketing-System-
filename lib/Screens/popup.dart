import 'package:flutter/material.dart';
import 'package:sam_app/Screens/homepage.dart';

class Popup extends StatelessWidget {
  const Popup({Key? key}) : super(key: key);

  // Method to show the pop-up dialog
  void showPopUpMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submitted!'),
          content: const Text('Your request has been submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Navigate back to the previous screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                   builder: (BuildContext context) =>  HomePage()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
