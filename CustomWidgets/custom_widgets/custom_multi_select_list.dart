// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomMultiSelectList<T> extends StatelessWidget {
  final List<CustomMultiSelectModel<T>> items;
  final Widget Function(CustomMultiSelectModel<T> item)? itemWidget;

  CustomMultiSelectList({
    required this.items,
    this.itemWidget,
  });

  late _WidgetNotifier<T> widgetNotifier;

  @override
  Widget build(BuildContext context) {
    widgetNotifier = _WidgetNotifier(items);

    return ValueListenableBuilder<List<CustomMultiSelectModel<T>>>(
      valueListenable: widgetNotifier,
      builder: (_, value, __) => Wrap(
        children: List.generate(
          value.length,
          (index) => multiSelectItem(value[index]),
        ),
      ),
    );
  }

  Widget multiSelectItem(CustomMultiSelectModel<T> item) {
    return InkWell(
      onTap: () {
        items[item.index].isSelected = !items[item.index].isSelected;
        widgetNotifier.value = items;
      },
      child: itemWidget != null
          ? itemWidget!.call(item)
          : Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: item.isSelected ? Colors.blue[200] : Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(0, 8),
                    blurRadius: 8,
                  )
                ],
              ),
              child: FittedBox(
                child: Text(item.data.toString()),
              ),
            ),
    );
  }
}

class CustomMultiSelectModel<T> {
  late int index;
  late bool isSelected;
  late T data;

  CustomMultiSelectModel(this.index, this.isSelected, this.data);

  CustomMultiSelectModel.fromMap(Map map) {
    index = map["Index"];
    isSelected = map["IsSelected"];
    data = map["Data"];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["Index"] = index;
    map["IsSelected"] = isSelected;
    map["Data"] = data;
    return map;
  }
}

class _WidgetNotifier<T>
    extends ValueNotifier<List<CustomMultiSelectModel<T>>> {
  _WidgetNotifier(List<CustomMultiSelectModel<T>> value) : super(value);

  @override
  List<CustomMultiSelectModel<T>> get value => super.value;

  @override
  set value(List<CustomMultiSelectModel<T>> newValue) {
    super.value = newValue;
    trigger();
  }

  trigger() => notifyListeners();
}
