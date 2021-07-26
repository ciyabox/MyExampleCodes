/* Use Example
  myNotifier.increase();


  ValueListenableBuilder(
    valueListenable: myNotifier,
    builder: (_, value, __) {
      return Center(child: Text(myNotifier.getNumber.toString()));
    },
  ),

*/

import 'package:flutter/material.dart';

final MyNotifier myNotifier = MyNotifier();

class MyNotifier extends ValueNotifier<int> {
  MyNotifier() : super(0);

  int _number = 0;

  int get getNumber => _number;
  set setNumber(int number) {
    _number = number;
  }

  increase() {
    _number++;
    notifyListeners();
  }

  decrease() {
    _number--;
    notifyListeners();
  }
}
