import 'package:json_annotation/json_annotation.dart';


part 'review.g.dart';

@JsonSerializable()


class Review {

  final String review;
  final String username;
  final String imageUrl;
  final int tourId;



  Review({required this.review,required this.username, required this.imageUrl, required this.tourId});


  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);

  /// Connect the generated [_$ReviewToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReviewToJson(this);


}




