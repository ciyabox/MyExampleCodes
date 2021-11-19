// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final Widget? iconWidget;
  final bool suffixActive;
  final TextInputType keyboardType;
  final int? maxLength;
  final Size maxSize;
  final TextAlign align;
  final double radius;
  final TextStyle? style;
  final List<BoxShadow>? shadows;
  final FocusNode? focus;

  CustomTextFormField({
    this.controller,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.errorText,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.iconWidget,
    this.suffixActive = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.maxSize = const Size(double.infinity, 56),
    this.align = TextAlign.start,
    this.radius = 12,
    this.style,
    this.shadows,
    this.focus,
  });
  TextStyle? _style;
  final hideNotifier = _hideNotifier(false);

  @override
  Widget build(BuildContext context) {
    _style = style;
    hideNotifier.value = suffixActive;
    return Container(
      // design
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxWidth: maxSize.width,
        maxHeight: maxSize.height,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: _textFormField(context),
    );
  }

  Widget _textFormField(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: hideNotifier,
      builder: (_, value, __) {
        return TextFormField(
          textAlign: align,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            icon: iconWidget,
            suffixIcon: suffixActive
                ? IconButton(
                    icon: value
                        ? Icon(Icons.visibility_outlined)
                        : Icon(Icons.visibility_off_outlined),
                    onPressed: () => hideNotifier.value = !value,
                  )
                : null,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            counterText: "",
            hintText: hintText,
            errorText: errorText,
            label: labelText != null ? Text(labelText!) : null,
            hintStyle: _style,
            labelStyle: _style,
            floatingLabelStyle: _style,
          ),
          textInputAction: TextInputAction.next,
          style: _style,
          obscureText: value,
          keyboardType: keyboardType,
          maxLength: maxLength,
          focusNode: focus,
          controller: controller,
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
          onChanged: onChanged,
        );
      },
    );
  }
}

class _hideNotifier<bool> extends ValueNotifier<bool> {
  _hideNotifier(bool value) : super(value);

  @override
  bool get value => super.value;

  @override
  set value(bool newValue) {
    super.value = newValue;
    notifyListeners();
  }
}
