import 'review.dart';

class PlaceDetail {
  final int id;
  final String name;
  final String description;
  final String location;
  final String country;
  final List<String> images;
  final List<Review> reviews;

//<editor-fold desc="Data Methods">
  const PlaceDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.country,
    required this.images,
    required this.reviews,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceDetail &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          location == other.location &&
          country == other.country &&
          images == other.images &&
          reviews == other.reviews);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      location.hashCode ^
      country.hashCode ^
      images.hashCode ^
      reviews.hashCode;

  @override
  String toString() {
    return 'PlaceDetail{' +
        ' id: $id,' +
        ' name: $name,' +
        ' description: $description,' +
        ' location: $location,' +
        ' country: $country,' +
        ' images: $images,' +
        ' reviews: $reviews,' +
        '}';
  }

  PlaceDetail copyWith({
    int? id,
    String? name,
    String? description,
    String? location,
    String? country,
    List<String>? images,
    List<Review>? reviews,
  }) {
    return PlaceDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      country: country ?? this.country,
      images: images ?? this.images,
      reviews: reviews ?? this.reviews,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'location': this.location,
      'country': this.country,
      'images': this.images,
      'reviews': this.reviews,
    };
  }

  factory PlaceDetail.fromMap(Map<String, dynamic> map) {
    return PlaceDetail(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      country: map['country'] as String,
      images: (map['images'] as List).map((e) => e as String).toList(),
      reviews: (map['reviews'] as List).map((e) => Review.fromMap(e)).toList(),
    );
  }

//</editor-fold>
}
