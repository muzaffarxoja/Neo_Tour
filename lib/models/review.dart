class Review {
  final String review;
  final String username;
  final String imageUrl;
  final int tourId;

//<editor-fold desc="Data Methods">
  const Review({
    required this.review,
    required this.username,
    required this.imageUrl,
    required this.tourId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          runtimeType == other.runtimeType &&
          review == other.review &&
          username == other.username &&
          imageUrl == other.imageUrl &&
          tourId == other.tourId);

  @override
  int get hashCode =>
      review.hashCode ^ username.hashCode ^ imageUrl.hashCode ^ tourId.hashCode;

  @override
  String toString() {
    return 'Review{' +
        ' review: $review,' +
        ' username: $username,' +
        ' imageUrl: $imageUrl,' +
        ' tourId: $tourId,' +
        '}';
  }

  Review copyWith({
    String? review,
    String? username,
    String? imageUrl,
    int? tourId,
  }) {
    return Review(
      review: review ?? this.review,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
      tourId: tourId ?? this.tourId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'review': this.review,
      'username': this.username,
      'imageUrl': this.imageUrl,
      'tourId': this.tourId,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      review: map['review'] as String,
      username: map['username'] as String,
      imageUrl: map['imageUrl'] as String,
      tourId: map['tourId'] as int,
    );
  }

//</editor-fold>
}