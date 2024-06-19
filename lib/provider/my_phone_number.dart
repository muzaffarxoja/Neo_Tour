import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class MyPhoneNumber extends ChangeNotifier {
  PhoneNumber _phoneNumber =  PhoneNumber(isoCode: 'KG');

  PhoneNumber get phoneNumber  => _phoneNumber;

  set phoneNumber(PhoneNumber value) {
    _phoneNumber = value;
    notifyListeners(); // Notify listeners about the change
  }
}