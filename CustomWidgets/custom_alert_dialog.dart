import 'package:flutter/material.dart';

class CustomAlertDialog {
  final String title;
  final String description;
  final Function() okFunction;
  final Function()? notOkFunction;

  CustomAlertDialog({
    required this.title,
    required this.description,
    required this.okFunction,
    this.notOkFunction,
  });

  show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            _buildActionButton(
              context: context,
              isOK: false,
              buttonFunction: notOkFunction,
            ),
            _buildActionButton(
              context: context,
              isOK: true,
              buttonFunction: okFunction,
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required bool isOK,
    Function()? buttonFunction,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isOK ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(24),
      ),
      child: IconButton(
        icon: Icon(
          isOK ? Icons.check : Icons.close,
          color: iconColor ?? Colors.white,
        ),
        onPressed: () {
          buttonFunction?.call();
          Navigator.pop(context);
        },
      ),
    );
  }
}
