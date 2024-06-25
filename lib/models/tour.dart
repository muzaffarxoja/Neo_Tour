import 'package:json_annotation/json_annotation.dart';
import 'package:neo_tour/models/review.dart';



part 'tour.g.dart';

@JsonSerializable()


class Tour {
  final int id;
  final String name;
  final String description;
  final String location;
  final String country;
  final List<String> images;
  final List<Review> reviews;




  Tour({required this.id,required this.name, required this.description,
    required this.location,required this.country, required this.images, required this.reviews});


  factory Tour.fromJson(Map<String, dynamic> json) =>
      _$TourFromJson(json);

  /// Connect the generated [_$TourToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TourToJson(this);


}