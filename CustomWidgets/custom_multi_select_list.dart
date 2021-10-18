import 'package:flutter/material.dart';

class CustomMultiSelectList<T> extends StatelessWidget {
  final List<CustomMultiSelectModel<T>> items;
  final Widget Function(CustomMultiSelectModel<T> item)? itemWidget;

  CustomMultiSelectList(this.items, {this.itemWidget});

  late var _custumMultiSelectNotifier = _CustumMultiSelectNotifier(items);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _custumMultiSelectNotifier,
      builder: (_, value, __) => Wrap(
        children: items.map((e) => _multiSelectItem(e)).toList(),
      ),
    );
  }

  Widget _multiSelectItem(CustomMultiSelectModel<T> item) {
    return InkWell(
      onTap: () {
        items[item.index].isSelected = !items[item.index].isSelected;
        _custumMultiSelectNotifier.value = items;
      },
      child: itemWidget != null
          ? itemWidget!.call(item)
          : Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(8),
              constraints: BoxConstraints.loose(const Size(200, 40)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color:
                    item.isSelected ? Colors.deepPurple[200] : Colors.grey[200],
                border: Border.all(),
              ),
              child: FittedBox(child: Text(item.value.toString())),
            ),
    );
  }
}

class CustomMultiSelectModel<T> {
  late int index;
  late bool isSelected;
  late T value;

  CustomMultiSelectModel(this.index, this.isSelected, this.value);
}

class _CustumMultiSelectNotifier extends ValueNotifier<List> {
  _CustumMultiSelectNotifier(List value) : super(value);

  @override
  List get value => super.value;

  @override
  set value(List newValue) {
    super.value = newValue;
    notifyListeners();
  }
}
