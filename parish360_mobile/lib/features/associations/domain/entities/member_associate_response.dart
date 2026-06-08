import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';

class MemberAssociateResponse {
  final String? id;
  final List<MemberInfo>? members;

  MemberAssociateResponse({this.id, this.members});

  factory MemberAssociateResponse.fromJson(Map<String, dynamic> json) {
    return MemberAssociateResponse(
      id: json['id'] as String?,
      members: json['members'] != null
          ? (json['members'] as List<Map<String, dynamic>>)
                .map((member) => MemberInfo.fromJson(member))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'members': members?.map((member) => member.toJson()).toList(),
    };
  }
}
