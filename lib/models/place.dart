import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()


class Place {
  final int id;
  final String name;
  final String image;

  Place({required this.id,required this.name, required this.image});


  factory Place.fromJson(Map<String, dynamic> json) =>
      _$PlaceFromJson(json);

  /// Connect the generated [_$PlaceToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlaceToJson(this);


}