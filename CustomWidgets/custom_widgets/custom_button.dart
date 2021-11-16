import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final double radius;
  final Color backgroundColor;
  final Size maxSize;

  const CustomButton({
    required this.child,
    required this.onPressed,
    this.radius = 12,
    this.backgroundColor = Colors.white,
    this.maxSize = const Size(double.infinity, 100),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        constraints: BoxConstraints(
          maxWidth: maxSize.width,
          maxHeight: maxSize.height,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: MaterialButton(
          child: child,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
