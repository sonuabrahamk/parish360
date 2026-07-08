import 'package:parish360_mobile/core/common/entities/place.dart';

class AfterlifeInfo {
  final String? cemetery;
  final DateTime? dod;
  final Place? cemeteryPlace;
  final Place? placeOfDeath;

  AfterlifeInfo({
    this.cemetery,
    this.dod,
    this.cemeteryPlace,
    this.placeOfDeath,
  });

  factory AfterlifeInfo.fromJson(Map<String, dynamic> json) {
    return AfterlifeInfo(
      cemetery: json['cemetery'] as String?,
      dod: json['dod'] != null ? DateTime.parse(json['dod'] as String) : null,
      cemeteryPlace: json['cemetery_place'] != null
          ? Place.fromJson(json['cemetery_place'] as Map<String, dynamic>)
          : null,
      placeOfDeath: json['place_of_death'] != null
          ? Place.fromJson(json['place_of_death'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cemetery': cemetery,
      'dod': dod?.toIso8601String(),
      'cemetery_place': cemeteryPlace?.toJson(),
      'place_of_death': placeOfDeath?.toJson(),
    };
  }
}
