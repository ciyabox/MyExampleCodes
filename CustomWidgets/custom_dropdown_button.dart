// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<T> items;
  final void Function(T value) onChanged;
  final Widget Function(T value)? child;
  final Widget? hint;
  final int startIndex;

  CustomDropdownButton({
    required this.items,
    required this.onChanged,
    this.child,
    this.hint,
    this.startIndex = 0,
  });

  final _CustomDropdownButtonNotifier<T?> _dropdownValueNotifier =
      _CustomDropdownButtonNotifier(null);

  @override
  Widget build(BuildContext context) {
    _dropdownValueNotifier.value = hint != null ? null : items[startIndex];

    return ValueListenableBuilder<T?>(
      valueListenable: _dropdownValueNotifier,
      builder: (_, value, __) => _buildDropdown(),
    );
  }

  DropdownButton<T> _buildDropdown() {
    return DropdownButton<T>(
      isExpanded: true,
      underline: const SizedBox.shrink(),

      // Design
      hint: hint,

      // Controller
      value: _dropdownValueNotifier.value,
      onChanged: (value) {
        _dropdownValueNotifier.value = value;
        onChanged.call(_dropdownValueNotifier.value!);
      },
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: child != null ? child!.call(e) : Text(e.toString()),
              ))
          .toList(),
    );
  }
}

class _CustomDropdownButtonNotifier<T> extends ValueNotifier<T> {
  _CustomDropdownButtonNotifier(T value) : super(value);

  @override
  T get value => super.value;

  @override
  set value(T newValue) {
    super.value = newValue;
    notifyListeners();
  }
}
