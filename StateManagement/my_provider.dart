/*  Use Example
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MyApp(),
    ),
  );
  
  
  MyProvider myProvider = Provider.of<MyProvider>(context);

  myProvider.increase();
  myProvider.decrease();
  
  Consumer<MyProvider>(
    builder: (_, value, __) => Center(
      child: Text(value.getNumber.toString()),
    ),
  ),
  Consumer2<MyProvider, MyProvider2>(
    builder: (_, value, value2, __) => Center(
      child: Text("${value.getNumber} - ${value2.getNumber2}"),
    ),
  ),
  
*/


import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
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
