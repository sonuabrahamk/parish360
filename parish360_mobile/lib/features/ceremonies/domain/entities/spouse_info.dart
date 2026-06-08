import 'package:parish360_mobile/core/common/entities/god_parent.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/church_info.dart';

class SpouseInfo {
  final String? spouseName;
  final String? spouseBaptismName;
  final String? spouseFather;
  final String? spouseMother;
  final String? spouseMaritalStatus;
  final DateTime? spouseDob;
  final String? spouseContact;
  final String? spouseEmail;
  final String? spouseAddress;
  final GodParent? godFather;
  final GodParent? godMother;
  final Place? birthPlace;
  final ChurchInfo? spouseChurch;

  SpouseInfo({
    this.spouseName,
    this.spouseBaptismName,
    this.spouseFather,
    this.spouseMother,
    this.spouseMaritalStatus,
    this.spouseDob,
    this.spouseContact,
    this.spouseEmail,
    this.spouseAddress,
    this.godFather,
    this.godMother,
    this.birthPlace,
    this.spouseChurch,
  });

  factory SpouseInfo.fromJson(Map<String, dynamic> json) {
    return SpouseInfo(
      spouseName: json['spouse_name'] as String?,
      spouseBaptismName: json['spouse_baptism_name'] as String?,
      spouseFather: json['spouse_father'] as String?,
      spouseMother: json['spouse_mother'] as String?,
      spouseMaritalStatus: json['spouse_marital_status'] as String?,
      spouseDob: json['spouse_dob'] != null
          ? DateTime.parse(json['spouse_dob'] as String)
          : null,
      spouseContact: json['spouse_contact'] as String?,
      spouseEmail: json['spouse_email'] as String?,
      spouseAddress: json['spouse_address'] as String?,
      godFather: json['god_father'] != null
          ? GodParent.fromJson(json['god_father'])
          : null,
      godMother: json['god_mother'] != null
          ? GodParent.fromJson(json['god_mother'])
          : null,
      birthPlace: json['birth_place'] != null
          ? Place.fromJson(json['birth_place'])
          : null,
      spouseChurch: json['spouse_church'] != null
          ? ChurchInfo.fromJson(json['spouse_church'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spouse_name': spouseName,
      'spouse_baptism_name': spouseBaptismName,
      'spouse_father': spouseFather,
      'spouse_mother': spouseMother,
      'spouse_marital_status': spouseMaritalStatus,
      'spouse_dob': spouseDob,
      'spouse_contact': spouseContact,
      'spouse_email': spouseEmail,
      'spouse_address': spouseAddress,
      'god_father': godFather?.toJson(),
      'god_mother': godMother?.toJson(),
      'birth_place': birthPlace?.toJson(),
      'spouse_church': spouseChurch?.toJson(),
    };
  }
}
