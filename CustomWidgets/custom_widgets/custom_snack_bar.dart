import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum SnackBarType { success, warning, error }

class CustomSnackBar {
  final String text;
  final SnackBarType type;
  final TextStyle? style;

  CustomSnackBar({
    required this.text,
    this.type = SnackBarType.error,
    this.style,
  });

  show(BuildContext context) => _build().show(context);

  Flushbar _build() {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.all(12),
      backgroundColor: _getColor(type),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      messageText: Text(text,style: style ?? TextStyle(color: Colors.white)),
    );
  }

  Color _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.error:
        return Colors.red;
      default:
        return Colors.red;
    }
  }
}
