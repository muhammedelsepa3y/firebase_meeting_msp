import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isPasswordVisible => _isPasswordVisible;


  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

}