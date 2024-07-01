import 'package:json_annotation/json_annotation.dart';

part "booking.g.dart";

@JsonSerializable()
class Booking {
  //final int id;
  final String phone;
  final String comment;
  final int people_amount;
  //final String username;
  final int tourId;
  Booking(
      {//required this.id,
      required this.phone,
      required this.comment,
      required this.people_amount,
      //required this.username,
      required this.tourId});

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  /// Connect the generated [_$BookingToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
