import 'package:flutter/material.dart';

class CustomAlertDialog {
  final String title;
  final String text;
  final Function() okFunction;
  final Function()? notOkFunction;

  CustomAlertDialog({
    required this.title,
    required this.text,
    required this.okFunction,
    this.notOkFunction,
  });

  show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            _buildActionButton(
              context: context,
              buttonFunction: notOkFunction,
              backgroundColor: Colors.red,
            ),
            _buildActionButton(
              context: context,
              buttonFunction: okFunction,
              backgroundColor: Colors.green,
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required Color backgroundColor,
    Function()? buttonFunction,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: IconButton(
        icon: Icon(Icons.close, color: iconColor ?? Colors.white),
        onPressed: () {
          buttonFunction?.call();
          Navigator.pop(context);
        },
      ),
    );
  }
}
