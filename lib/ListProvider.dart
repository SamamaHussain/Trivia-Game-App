import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier{
  List<int> numbersList = [1,2,3,4];
  void add (){
    var last =numbersList.last;
    numbersList.add(last+1);
    print("Called");
    print(numbersList);
    print(last);
    notifyListeners();
  }
  void remove(){
    numbersList.removeLast();
    notifyListeners();
  }
  
}