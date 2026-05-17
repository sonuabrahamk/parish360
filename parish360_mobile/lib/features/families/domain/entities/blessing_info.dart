class BlessingInfo {
  final String? id;
  final DateTime? date;
  final String? priest;
  final String? reason;

  BlessingInfo({this.id, this.date, this.priest, this.reason});

  factory BlessingInfo.fromJson(Map<String, dynamic> json) {
    return BlessingInfo(
      id: json['id'] as String?,
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : null,
      priest: json['priest'] as String?,
      reason: json['reason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'priest': priest,
      'reason': reason,
    };
  }
}
