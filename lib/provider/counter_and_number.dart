import 'package:flutter/material.dart';



class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

}



// class MyPhoneNumber extends ChangeNotifier {
//   PhoneNumber _phoneNumber =  PhoneNumber(isoCode: 'KG');
//
//   PhoneNumber get phoneNumber  => _phoneNumber;
//
//   set phoneNumber(PhoneNumber value) {
//     _phoneNumber = value;
//     notifyListeners(); // Notify listeners about the change
//   }
// }
