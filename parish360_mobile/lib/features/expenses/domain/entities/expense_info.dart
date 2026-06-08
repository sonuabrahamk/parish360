class ExpenseInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? paidTo;
  final String? paidBy;
  final DateTime? date;
  final String? description;
  final double? amount;
  final String? currency;
  final double? conversionRate;
  final String? accountId;

  ExpenseInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.paidTo,
    this.paidBy,
    this.date,
    this.description,
    this.amount,
    this.currency,
    this.conversionRate,
    this.accountId,
  });

  factory ExpenseInfo.fromJson(Map<String, dynamic> json) {
    return ExpenseInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      paidTo: json['paid_to'] as String?,
      paidBy: json['paid_by'] as String?,
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : null,
      description: json['description'] as String?,
      amount: json['amount'] as double?,
      currency: json['currency'] as String?,
      conversionRate: json['conversion_rate'] as double?,
      accountId: json['account_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
      'paid_to': paidTo,
      'paid_by': paidBy,
      'date': date,
      'description': description,
      'amount': amount,
      'currency': currency,
      'conversion_rate': conversionRate,
      'account_id': accountId,
    };
  }
}
