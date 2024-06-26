import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neo_tour/models/place.dart';
import 'package:neo_tour/models/place_detail.dart';

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

  Future<PlaceDetail> getPlaceDetails(String id) async {
    try {
      final response = await dio
          .get("https://neotour-production-392c.up.railway.app/api/tours/$id");

      final data = response.data; // Dio already decodes the JSON for you
      PlaceDetail place = PlaceDetail.fromMap(data);
      return place;
    } catch (e) {
      print('Request failed with error: $e');
      throw Exception('Failed to load place details');
    }
  }
}
