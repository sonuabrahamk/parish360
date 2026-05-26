import 'package:parish360_mobile/core/common/entities/god_parent.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';

class MemberInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? firstName;
  final String? lastName;
  final String? baptismName;
  final String? email;
  final String? contact;
  final bool? contactVerified;
  final String? maritalStatus;
  final DateTime? dob;
  final String? gender;
  final String? father;
  final String? mother;
  final String? qualification;
  final String? occupation;
  final String? relationship;
  final GodParent? godFather;
  final GodParent? godMother;
  final Place? birthPlace;

  MemberInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.firstName,
    this.contact,
    this.contactVerified,
    this.dob,
    this.father,
    this.mother,
    this.relationship,
    this.lastName,
    this.baptismName,
    this.email,
    this.maritalStatus,
    this.gender,
    this.qualification,
    this.occupation,
    this.godFather,
    this.godMother,
    this.birthPlace,
  });

  factory MemberInfo.fromJson(Map<String, dynamic> json) {
    return MemberInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      firstName: json['first_name'] as String?,
      contact: json['contact'] as String?,
      contactVerified: json['contact_verified'] as bool?,
      dob: json['dob'] != null ? DateTime.parse(json['dob'] as String) : null,
      father: json['father'] as String?,
      mother: json['mother'] as String?,
      relationship: json['relationship'] as String?,
      lastName: json['last_name'] as String?,
      baptismName: json['baptism_name'] as String?,
      email: json['email'] as String?,
      maritalStatus: json['marital_status'] as String?,
      gender: json['gender'] as String?,
      qualification: json['qualification'] as String?,
      occupation: json['occupation'] as String?,
      godFather: json['god_father'] != null
          ? GodParent.fromJson(json['god_father'])
          : null,
      godMother: json['god_mother'] != null
          ? GodParent.fromJson(json['god_mother'])
          : null,
      birthPlace: json['birth_place'] != null
          ? Place.fromJson(json['birth_place'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'first_name': firstName,
      'contact': contact,
      'contact_verified': contactVerified,
      'dob': dob?.toIso8601String(),
      'father': father,
      'mother': mother,
      'relationship': relationship,
      'last_name': lastName,
      'baptism_name': baptismName,
      'email': email,
      'marital_status': maritalStatus,
      'gender': gender,
      'qualification': qualification,
      'occupation': occupation,
      'god_father': godFather?.toJson(),
      'god_mother': godMother?.toJson(),
      'birth_place': birthPlace?.toJson(),
    };
  }

  MemberInfo copyWith({
    String? id,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? firstName,
    String? contact,
    bool? contactVerified,
    DateTime? dob,
    String? father,
    String? mother,
    String? relationship,
    String? lastName,
    String? baptismName,
    String? email,
    String? maritalStatus,
    String? gender,
    String? qualification,
    String? occupation,
    GodParent? godFather,
    GodParent? godMother,
    Place? birthPlace,
  }) {
    return MemberInfo(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      firstName: firstName ?? this.firstName,
      contact: contact ?? this.contact,
      contactVerified: contactVerified ?? this.contactVerified,
      dob: dob ?? this.dob,
      father: father ?? this.father,
      mother: mother ?? this.mother,
      relationship: relationship ?? this.relationship,
      lastName: lastName ?? this.lastName,
      baptismName: baptismName ?? this.baptismName,
      email: email ?? this.email,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      gender: gender ?? this.gender,
      qualification: qualification ?? this.qualification,
      occupation: occupation ?? this.occupation,
      godFather: godFather ?? this.godFather,
      godMother: godMother ?? this.godMother,
      birthPlace: birthPlace ?? this.birthPlace,
    );
  }
}
