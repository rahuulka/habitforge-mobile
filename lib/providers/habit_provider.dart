import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  String userName = "Rahul";

  void init() {
    // Database will be added in next commit
    notifyListeners();
  }

  void updateName(String name) {
    userName = name;
    notifyListeners();
  }
}