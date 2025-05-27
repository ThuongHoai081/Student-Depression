import 'dart:core';

abstract class Endpoints {
  static const String apiUrl = 'http://localhost:8000/api';

  static const String predict = '$apiUrl/predict/';
}
