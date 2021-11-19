// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final AlignmentGeometry scrollAlign;
  final TextAlign? align;
  final bool isFitted;

  const CustomText(
    this.text, {
    this.style,
    this.scrollAlign = Alignment.center,
    this.align,
    this.isFitted = true,
  });

  @override
  Widget build(BuildContext context) {
    return isFitted
        ? FittedBox(fit: BoxFit.scaleDown, child: _text())
        : Align(
            alignment: scrollAlign,
            child: SingleChildScrollView(child: _text()),
          );
  }

  Text _text() => Text(
        text,
        textAlign: align,
        style: style,
      );
}
