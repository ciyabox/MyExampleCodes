import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final AlignmentGeometry align;
  final EdgeInsets padding;
  final Color color;
  final double radius;
  final Size maxSize;
  final List<BoxShadow>? shadows;
  final bool isEnebled;

  const CustomButton({
    required this.child,
    required this.onPressed,
    this.align = Alignment.center,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
    this.color = Colors.white,
    this.radius = 12,
    this.maxSize = const Size(double.infinity, 56),
    this.shadows,
    this.isEnebled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxSize.width,
        maxHeight: maxSize.height,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: shadows == null
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: Offset(0, 8),
                  blurRadius: 8,
                )
              ]
            : shadows!.isEmpty
                ? null
                : shadows,
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: isEnebled ? onPressed : null,
        child: Container(
          alignment: align,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}