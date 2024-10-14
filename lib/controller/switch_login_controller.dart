import 'package:flutter/material.dart';

class SwitchLoginController extends ChangeNotifier{
  bool _isLogin = true;

  bool get isLogin => _isLogin;
  void toggleLog(){
    _isLogin = !_isLogin;
    notifyListeners();
  }
}