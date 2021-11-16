import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChange;
  final String? Function(String? value)? validator;
  final String? initialValue;
  final Widget? iconWidget;
  final String? hintText;
  final bool hide;
  final TextStyle? style;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final int? maxLength;
  final Size maxSize;

  CustomTextFormField({
    this.onSaved,
    this.onChange,
    this.validator,
    this.initialValue,
    this.iconWidget,
    this.hintText,
    this.hide = false,
    this.style,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.maxLength,
    this.maxSize = const Size(double.infinity, double.infinity),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // design
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: maxSize.width,
          maxHeight: maxSize.height,
        ),
        alignment: Alignment.centerLeft,
        child: _textFormField(),
      ),
    );
  }

  Widget _textFormField() {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        icon: iconWidget,
        hintText: hintText,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        counterText: "",
      ),
      textInputAction: TextInputAction.next,
      style: style,
      obscureText: hide,
      keyboardType: keyboardType,
      maxLength: maxLength,
      controller: controller,
      initialValue: initialValue,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChange,
    );
  }
}
