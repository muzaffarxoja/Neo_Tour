// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      phone: json['phone'] as String,
      comment: json['comment'] as String,
      people_amount: (json['people_amount'] as num).toInt(),
      tourId: (json['tourId'] as num).toInt(),
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'phone': instance.phone,
      'comment': instance.comment,
      'people_amount': instance.people_amount,
      'tourId': instance.tourId,
    };
