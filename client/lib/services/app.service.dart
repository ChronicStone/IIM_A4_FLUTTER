import 'package:flutter/material.dart';

class AppService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
  }
}
