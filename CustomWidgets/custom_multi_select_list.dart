// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomMultiSelectList extends StatelessWidget {
  final List<CustomMultiSelectModel> items;
  final Widget Function(CustomMultiSelectModel item)? itemWidget;

  CustomMultiSelectList({
    required this.items,
    this.itemWidget,
  });

  late var custumMultiSelectNotifier = CustumMultiSelectNotifier(items);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: custumMultiSelectNotifier,
      builder: (_, value, __) => Wrap(
        children: List.generate(
          items.length,
          (index) => multiSelectItem(items[index]),
        ),
      ),
    );
  }

  Widget multiSelectItem(CustomMultiSelectModel item) {
    return InkWell(
      onTap: () {
        items[item.index].isSelected = !items[item.index].isSelected;
        custumMultiSelectNotifier.value = items;
      },
      child: itemWidget != null
          ? itemWidget!.call(item)
          : Card(
              margin: const EdgeInsets.all(4),
              elevation: 8,
              color: item.isSelected ? Colors.purple[200] : Colors.white,
              shadowColor: item.isSelected ? Colors.purple[200] : Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(child: Text(item.text)),
              ),
            ),
    );
  }
}

class CustomMultiSelectModel {
  late int index;
  late bool isSelected;
  late String text;

  CustomMultiSelectModel(this.index, this.isSelected, this.text);
  CustomMultiSelectModel.fromMap(Map map) {
    index = map["Index"];
    isSelected = map["IsSelected"];
    text = map["Text"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["Index"] = index;
    map["IsSelected"] = isSelected;
    map["Text"] = text;

    return map;
  }
}

class CustumMultiSelectNotifier extends ValueNotifier<List> {
  CustumMultiSelectNotifier(List value) : super(value);

  @override
  List get value => super.value;

  @override
  set value(List newValue) {
    super.value = newValue;
    notifyListeners();
  }
}
