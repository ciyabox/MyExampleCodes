import 'package:flutter/material.dart';

class CustomMultiSelectList extends StatelessWidget {
  final List<CustomMultiSelectModel> items;
  final Widget Function(CustomMultiSelectModel item)? itemWidget;

  CustomMultiSelectList({
    required this.items,
    this.itemWidget,
  });

  final screenNotifier = _ScreenNotifier(List.empty(growable: true));

  @override
  Widget build(BuildContext context) {
    screenNotifier.value = items;
    return ValueListenableBuilder(
      valueListenable: screenNotifier,
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
        screenNotifier.value = items;
      },
      child: itemWidget != null
          ? itemWidget!.call(item)
          : Card(
              margin: const EdgeInsets.all(4),
              elevation: 4,
              color: item.isSelected ? Colors.purple[200] : Colors.white,
              shadowColor: item.isSelected ? Colors.purple[200] : Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FittedBox(child: Text(item.data.toString())),
              ),
            ),
    );
  }
}

class CustomMultiSelectModel {
  late int index;
  late bool isSelected;
  late dynamic data;

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

class _ScreenNotifier extends ValueNotifier<List> {
  _ScreenNotifier(List value) : super(value);
  @override
  List get value => super.value;
  @override
  set value(List newValue) {
    super.value = newValue;
    notifyListeners();
  }
}
