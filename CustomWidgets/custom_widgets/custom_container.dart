import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final AlignmentGeometry align;
  final EdgeInsets padding;
  final Color color;
  final double radius;
  final Size maxSize;
  final List<BoxShadow>? shadows;
  final ImageProvider? image;
  final BoxFit? fit;

  const CustomContainer({
    this.child,
    this.align = Alignment.center,
    this.padding = const EdgeInsets.symmetric(vertical: 4,horizontal: 12),
    this.color = Colors.white,
    this.radius = 12,
    this.shadows,
    this.maxSize = const Size(double.infinity, 56),
    this.image,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: align,
      padding: padding,
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
        image: image == null ? null : DecorationImage(image: image!, fit: fit),
      ),
      child: child,
    );
  }
}
