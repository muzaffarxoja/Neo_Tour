import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neo_tour/models/place.dart';


import '../../models/tour.dart';

class PlacesRepository {
  final Dio dio = Dio();

  Future<List<Place>> getPlaceList() async {
    try {
      final response = await dio
          .get("https://neotour-production-392c.up.railway.app/api/tours");

      List<dynamic> data =
          response.data; // Dio already decodes the JSON for you
      List<Place> placeList = data.map((json) => Place.fromJson(json)).toList();

      debugPrint(response.data.toString());
      return placeList;
    } catch (e) {
      print('Request failed with error: $e');
      return [];
    }
  }

  Future<List<Place>> getPlaceListByCategory(String category) async {
    try {
      final response = await dio
          .get("http://neotour-production-392c.up.railway.app/api/tours/by-category/$category");

      List<dynamic> data =
          response.data; // Dio already decodes the JSON for you
      List<Place> placeList = data.map((json) => Place.fromJson(json)).toList();

      //debugPrint(response.data.toString());
      return placeList;
    } catch (e) {
      print('Request failed with error: $e');
      return [];
    }
  }

  Future<Tour> getPlaceDetail(String id) async {
    try {
      final response = await dio
          .get("https://neotour-production-392c.up.railway.app/api/tours/$id");

      dynamic data =
          response.data; // Dio already decodes the JSON for you
      Tour placeDetail =Tour.fromJson(data);


      debugPrint(response.data.toString());
      return placeDetail;
    } catch (e) {
      print('Request failed with error: $e');
      rethrow;
    }
  }



}
