// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final bool isUnderline;
  final TextStyle? style;
  final EdgeInsets padding;

  const CustomTextButton({
    required this.buttonText,
    required this.onPressed,
    this.style,
    this.isUnderline = true,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: padding,
        child: Text(
          buttonText,
          style: (style ?? TextStyle()).copyWith(
              decoration: isUnderline ? TextDecoration.underline : null),
        ),
      ),
      onTap: onPressed,
    );
  }
}
