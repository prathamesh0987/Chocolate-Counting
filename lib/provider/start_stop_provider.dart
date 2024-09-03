import 'package:flutter/material.dart';

class StartStopProvider with ChangeNotifier {
  bool isStarted = false;

  bool get isStartedStatus => isStarted;

  void isStartedChanged(bool status) {
    isStarted = status;
    notifyListeners();
  }
}
