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

  
  Consumer<MyProvider>(
    builder: (_, value, __) {
      return Center(child: Text(value.getNumber.toString()));
    },
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
