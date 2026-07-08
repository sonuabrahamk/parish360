import 'package:parish360_mobile/core/common/entities/god_parent.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/afterlife_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/church_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/minister_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ordination_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/spouse_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/witness_info.dart';

class CeremonyInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? type;
  final DateTime? date;
  final bool? parishioner;
  final MinisterInfo? minister;
  final ChurchInfo? church;
  final String? name;
  final String? baptismName;
  final String? father;
  final String? mother;
  final DateTime? dob;
  final String? maritalStatus;
  final String? email;
  final String? contact;
  final String? address;
  final String? remarks;
  final GodParent? godFather;
  final GodParent? godMother;
  final Place? birthPlace;
  final SpouseInfo? spouse;
  final WitnessInfo? witness1;
  final WitnessInfo? witness2;
  final OrdinationInfo? ordination;
  final AfterlifeInfo? afterlife;
  final String? familyId;
  final String? parishId;

  CeremonyInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.type,
    this.date,
    this.parishioner,
    this.minister,
    this.church,
    this.name,
    this.baptismName,
    this.father,
    this.mother,
    this.dob,
    this.maritalStatus,
    this.email,
    this.contact,
    this.address,
    this.remarks,
    this.godFather,
    this.godMother,
    this.birthPlace,
    this.spouse,
    this.witness1,
    this.witness2,
    this.ordination,
    this.afterlife,
    this.familyId,
    this.parishId,
  });

  factory CeremonyInfo.fromJson(Map<String, dynamic> json) {
    return CeremonyInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      type: json['type'] as String?,
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : null,
      parishioner: json['parishioner'] as bool?,
      minister: json['minister'] != null
          ? MinisterInfo.fromJson(json['minister'])
          : null,
      church: json['church'] != null
          ? ChurchInfo.fromJson(json['church'])
          : null,
      name: json['name'] as String?,
      baptismName: json['baptism_name'] as String?,
      father: json['father'] as String?,
      mother: json['mother'] as String?,
      dob: json['dob'] != null ? DateTime.parse(json['dob'] as String) : null,
      maritalStatus: json['marital_status'] as String?,
      email: json['email'] as String?,
      contact: json['contact'] as String?,
      address: json['address'] as String?,
      remarks: json['remarks'] as String?,
      godFather: json['god_father'] != null
          ? GodParent.fromJson(json['god_father'])
          : null,
      godMother: json['god_mother'] != null
          ? GodParent.fromJson(json['god_mother'])
          : null,
      birthPlace: json['birth_place'] != null
          ? Place.fromJson(json['birth_place'])
          : null,
      spouse: json['spouse'] != null
          ? SpouseInfo.fromJson(json['spouse'])
          : null,
      witness1: json['witness1'] != null
          ? WitnessInfo.fromJson(json['witness1'])
          : null,
      witness2: json['witness2'] != null
          ? WitnessInfo.fromJson(json['witness2'])
          : null,
      ordination: json['ordination'] != null
          ? OrdinationInfo.fromJson(json['ordination'])
          : null,
      afterlife: json['afterlife'] != null
          ? AfterlifeInfo.fromJson(json['afterlife'])
          : null,
      familyId: json['family_id'] as String?,
      parishId: json['parish_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'type': type,
      'date': date?.toIso8601String(),
      'parishioner': parishioner,
      'minister': minister?.toJson(),
      'church': church?.toJson(),
      'name': name,
      'baptism_name': baptismName,
      'father': father,
      'mother': mother,
      'dob': dob?.toIso8601String(),
      'marital_status': maritalStatus,
      'email': email,
      'contact': contact,
      'address': address,
      'remarks': remarks,
      'god_father': godFather?.toJson(),
      'god_mother': godMother?.toJson(),
      'birth_place': birthPlace?.toJson(),
      'spouse': spouse?.toJson(),
      'witness1': witness1?.toJson(),
      'witness2': witness2?.toJson(),
      'ordination': ordination?.toJson(),
      'afterlife': afterlife?.toJson(),
      'family_id': familyId,
      'parish_id': parishId,
    };
  }
}
