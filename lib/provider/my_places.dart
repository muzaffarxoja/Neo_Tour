import 'package:flutter/material.dart';
import 'package:neo_tour/models/place.dart';



class MyPlaces extends ChangeNotifier {
  late List<Place> _places;

  List<Place> get places => _places;

  void increment() {

    notifyListeners();
  }

  void decrement() {

    notifyListeners();
  }

}