class SubscriptionInfo {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? year;
  final String? month;
  final double? amount;
  final String? currency;

  SubscriptionInfo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.year,
    this.month,
    this.amount,
    this.currency,
  });

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    return SubscriptionInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      year: json['year'] as String?,
      month: json['month'] as String?,
      amount: json['amount'] as double?,
      currency: json['currency'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'year': year,
      'month': month,
      'amount': amount,
      'currency': currency,
    };
  }
}
