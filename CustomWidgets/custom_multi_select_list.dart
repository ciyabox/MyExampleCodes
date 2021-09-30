import 'package:flutter/material.dart';

class CustomMultiSelectList extends StatelessWidget {
  final List<CustomMultiSelectModel> items;

  CustomMultiSelectList({
    required this.items,
  });

  late var custumMultiSelectNotifier =
      CustumMultiSelectNotifier(items);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ValueListenableBuilder(
        valueListenable: custumMultiSelectNotifier,
        builder: (_, value, __) => Wrap(
          children: List.generate(
            items.length,
            (index) => multiSelectItem(items[index]),
          ),
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
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints.loose(Size(200, 40)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: item.isSelected ? Colors.deepPurple[200] : Colors.grey[200],
            border: Border.all(color: Colors.black)),
        child: FittedBox(alignment: Alignment.center, child: Text(item.text)),
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
    this.index = map["Index"];
    this.isSelected = map["IsSelected"];
    this.text = map["Text"];
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
