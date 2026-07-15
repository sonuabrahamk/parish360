class PaymentInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? paidTo;
  final String? payee;
  final String? type;
  final String? description;
  final double? amount;
  final String? currency;
  final double? conversionRate;
  final String? bookingCode;
  final DateTime? subscriptionFrom;
  final DateTime? subscriptionTo;
  final String? paymentMode;
  final String? referenceId;
  final String? accountId;
  final String? familyCode;
  final String? parishId;

  PaymentInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.paidTo,
    this.payee,
    this.type,
    this.description,
    this.amount,
    this.currency,
    this.conversionRate,
    this.bookingCode,
    this.subscriptionFrom,
    this.subscriptionTo,
    this.paymentMode,
    this.referenceId,
    this.accountId,
    this.familyCode,
    this.parishId,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
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
      payee: json['payee'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      amount: json['amount'] as double?,
      currency: json['currency'] as String?,
      conversionRate: json['conversion_rate'] as double?,
      bookingCode: json['booking_code'] as String?,
      subscriptionFrom: json['subscription_from'] != null
          ? DateTime.parse(json['subscription_from'] as String)
          : null,
      subscriptionTo: json['subscription_to'] != null
          ? DateTime.parse(json['subscription_to'] as String)
          : null,
      paymentMode: json['payment_mode'] as String?,
      referenceId: json['referenceId'] as String?,
      accountId: json['account_id'] as String?,
      familyCode: json['family_code'] as String?,
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
      'paid_to': paidTo,
      'payee': payee,
      'type': type,
      'description': description,
      'amount': amount,
      'currency': currency,
      'conversion_rate': conversionRate,
      'booking_code': bookingCode,
      'subscription_from': subscriptionFrom?.toIso8601String(),
      'subscription_to': subscriptionTo?.toIso8601String(),
      'payment_mode': paymentMode,
      'referenceId': referenceId,
      'account_id': accountId,
      'family_code': familyCode,
      'parish_id': parishId,
    };
  }
}
