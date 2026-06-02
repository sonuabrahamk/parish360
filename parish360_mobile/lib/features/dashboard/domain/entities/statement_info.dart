class StatementInfo{
    final String? accountName;
    final DateTime? date;
    final String? type;
    final String? party;
    final String? description;
    final double? expense;
    final double? payment;
    final String? currency;

    StatementInfo({
      this.accountName,
      this.date,
      this.type,
      this.party,
      this.description,
      this.expense,
      this.payment,
      this.currency,
    });

    factory StatementInfo.fromJson(Map<String, dynamic> json) {
      return StatementInfo(
        accountName: json['account_name'],
        date: json['date'] != null ? DateTime.parse(json['date']) : null,
        type: json['type'],
        party: json['party'],
        description: json['description'],
        expense: json['expense'] != null ? double.parse(json['expense'].toString()) : null,
        payment: json['payment'] != null ? double.parse(json['payment'].toString()) : null,
        currency: json['currency'],
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'account_name': accountName,
        'date': date?.toIso8601String(),
        'type': type,
        'party': party,
        'description': description,
        'expense': expense,
        'payment': payment,
        'currency': currency,
      };
    }
}