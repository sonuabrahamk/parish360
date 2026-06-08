import 'package:parish360_mobile/core/common/entities/place.dart';

class ChurchInfo {
  final String? familyCode;
  final String? church;
  final String? diocese;
  final Place? churchLocation;

  ChurchInfo({this.familyCode, this.church, this.diocese, this.churchLocation});

  factory ChurchInfo.fromJson(Map<String, dynamic> json) {
    return ChurchInfo(
      familyCode: json['family_code'] as String?,
      church: json['church'] as String?,
      diocese: json['church'] as String?,
      churchLocation: json['church_location'] != null
          ? Place.fromJson(json['church_location'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'family_code': familyCode,
      'church': church,
      'diocese': diocese,
      'church_location': churchLocation?.toJson(),
    };
  }
}
