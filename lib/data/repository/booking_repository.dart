import 'package:dio/dio.dart';
import 'package:neo_tour/models/booking.dart';
import 'package:flutter/material.dart';

String token = '';

class BookingRepository {
  final Dio dio = Dio();

  BookingRepository() {
    dio.options = BaseOptions(
      baseUrl: 'https://neotour-production-392c.up.railway.app/api',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  //Future<Booking?>
  void book(

      //{required Booking bookingInfo}
      ) async {
    Booking? bookedUser;

    String url = '/login';
    Map<String, dynamic> data = {"username": "muzaffar", "password": "1234"};

    try {
      Response loginResponse = await dio.post(
        url,
        data: data,
      );

      //token = loginResponse.data["accessToken"];
      debugPrint(loginResponse.data.toString());

      //bookedUser = Booking.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    //return bookedUser;
  }
}
