import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final void Function(T value) onChanged;
  final Widget Function(T value)? child;
  final int startIndex;

  CustomDropdown({
    required this.items,
    required this.onChanged,
    this.child,
    this.startIndex = 0,
  });

  late _CustomDropdownNotifier<T> _genericDropdownNotifier;

  @override
  Widget build(BuildContext context) {
    _genericDropdownNotifier = _CustomDropdownNotifier(items[startIndex]);

    return ValueListenableBuilder<T>(
      valueListenable: _genericDropdownNotifier,
      builder: (_, value, __) => _buildDropdown(),
    );
  }

  DropdownButton<T> _buildDropdown() {
    return DropdownButton<T>(
      // Design
      isExpanded: true,

      // Controller
      value: _genericDropdownNotifier.value,
      onChanged: (value) {
        _genericDropdownNotifier.value = value ?? items.first;
        onChanged.call(_genericDropdownNotifier.value);
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

class _CustomDropdownNotifier<T> extends ValueNotifier<T> {
  _CustomDropdownNotifier(T value) : super(value);

  @override
  T get value => super.value;

  @override
  set value(T newValue) {
    super.value = newValue;
    notifyListeners();
  }
}
