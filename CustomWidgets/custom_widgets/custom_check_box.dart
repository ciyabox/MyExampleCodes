import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final Widget? child;
  final bool isLeftPosition;
  final void Function(bool? value)? onChanged;

  CustomCheckBox({
    this.child,
    this.onChanged,
    this.isLeftPosition = true,
  });

  final checkBoxValue = _CheckBoxNotifier<bool?>(null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: isLeftPosition
          ? [_checkBox(), Expanded(child: child ?? const SizedBox.shrink())]
          : [Expanded(child: child ?? const SizedBox.shrink()), _checkBox()],
    );
  }

  Widget _checkBox() {
    return ValueListenableBuilder<bool?>(
      valueListenable: checkBoxValue,
      builder: (_, value, __) {
        value ??= false;
        return Checkbox(
          // design

          // controller
          value: value,
          onChanged: (value) {
            checkBoxValue.value = value;
            onChanged?.call(value);
          },
        );
      },
    );
  }
}

class _CheckBoxNotifier<T> extends ValueNotifier<T> {
  _CheckBoxNotifier(T value) : super(value);

  @override
  T get value => super.value;

  @override
  set value(T newValue) {
    super.value = newValue;
    notifyListeners();
  }
}
