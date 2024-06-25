// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      review: json['review'] as String,
      username: json['username'] as String,
      imageUrl: json['imageUrl'] as String,
      tourId: (json['tourId'] as num).toInt(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'review': instance.review,
      'username': instance.username,
      'imageUrl': instance.imageUrl,
      'tourId': instance.tourId,
    };
