import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neo_tour/models/booking.dart';

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

  Future<String?> login(String username, String password) async {
    String url = '/login';
    Map<String, dynamic> data = {"username": username, "password": password};

    try {
      Response loginResponse = await dio.post(
        url,
        data: data,
      );

      // Extract token from response
      String token = loginResponse.data["accessToken"];
      // Update Dio headers with the new token
      dio.options.headers['Authorization'] = 'Bearer $token';

      debugPrint("Login successful. Token: $token");
      return token;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Error logging in: ${e.response?.statusCode}');
        debugPrint('Response data: ${e.response?.data}');
      } else {
        debugPrint('Error logging in: ${e.message}');
      }
      return null;
    }
  }

  Future<dynamic> book({required Booking bookingInfo}) async {

    // Ensure the user is logged in and we have a token
    String? token = await login("muzaffar", "1234");
    if (token == null) {
      print("Login failed. Cannot proceed with booking.");
      return null;
    }

    String url = '/bookings/add';
    Map<String, dynamic> data = bookingInfo.toJson();

    try {
      Response response = await dio.post(
        url,
        data: data,
      );

      debugPrint("Booking successful: ${response.data}");
      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Error creating booking: ${e.response?.statusCode}');
        debugPrint('Response data: ${e.response?.data}');
      } else {
        debugPrint('Error creating booking: ${e.message}');
      }
      return null;
    }
  }
}