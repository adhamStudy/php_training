import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String messageText;
  final bool isError;

  const CustomSnackbar({required this.messageText, required this.isError});

  void showCustomSnackbar(BuildContext context) {
    Color color = isError ? Colors.red : Colors.green;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(messageText),
        backgroundColor: color,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(); // Placeholder widget
  }
}
