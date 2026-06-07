import 'package:parish360_mobile/features/configurations/domain/entities/resource_info.dart';

class BookingInfo {
  final String? id;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? bookingCode;
  final String? bookedBy;
  final String? contact;
  final String? familyCode;
  final String? event;
  final String? description;
  final String? bookingType;
  final double? totalAmount;
  final double? amountPaid;
  final String? currency;
  final DateTime? bookedFrom;
  final DateTime? bookedTo;
  final String? resourceId;
  final String? status;
  final String? paymentStatus;
  final ResourceInfo? resource;

  BookingInfo({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.bookingCode,
    this.bookedBy,
    this.contact,
    this.familyCode,
    this.event,
    this.description,
    this.bookingType,
    this.totalAmount,
    this.amountPaid,
    this.currency,
    this.bookedFrom,
    this.bookedTo,
    this.resourceId,
    this.status,
    this.paymentStatus,
    this.resource,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) {
    return BookingInfo(
      id: json['id'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      updatedBy: json['updated_by'] as String?,
      bookingCode: json['booking_code'] as String?,
      bookedBy: json['booked_by'] as String?,
      contact: json['contact'] as String?,
      familyCode: json['family_code'] as String?,
      event: json['event'] as String?,
      description: json['description'] as String?,
      bookingType: json['bookin_type'] as String?,
      totalAmount: json['total_amount'] as double?,
      amountPaid: json['amount_paid'] as double?,
      currency: json['currency'] as String?,
      bookedFrom: json['booked_from'] != null
          ? DateTime.parse(json['booked_from'] as String)
          : null,
      bookedTo: json['booked_to'] != null
          ? DateTime.parse(json['booked_to'] as String)
          : null,
      resourceId: json['resource_id'] as String?,
      status: json['status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      resource: json['resource'] != null
          ? ResourceInfo.fromJson(json['resource'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'booking_code': bookingCode,
      'booked_by': bookedBy,
      'contact': contact,
      'family_code': familyCode,
      'event': event,
      'description': description,
      'booking_type': bookingType,
      'total_amount': totalAmount,
      'amount_paid': amountPaid,
      'currency': currency,
      'booked_from': bookedFrom,
      'booked_to': bookedTo,
      'resource_id': resourceId,
      'status': status,
      'payment_status': paymentStatus,
      'resource': resource?.toJson(),
    };
  }
}
