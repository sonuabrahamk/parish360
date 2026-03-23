class Place {
  final String? location;
  final String? city;
  final String? state;
  final String? country;

  Place({
    this.location,
    this.city,
    this.state,
    this.country,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      location: json['location'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'city': city,
      'state': state,
      'country': country,
    };
  }
}