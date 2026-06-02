class BookingRequest {
  final String? id;
  final String? bookingCode;
  final String? bookedBy;
  final String? contact;
  final String? familyCode;
  final String? event;
  final String? description;
  final String? bookingType;
  final DateTime? bookedFrom;
  final DateTime? bookedTo;
  final List<String>? items;

  BookingRequest({
    this.id,
    this.bookingCode,
    this.bookedBy,
    this.contact,
    this.familyCode,
    this.event,
    this.description,
    this.bookingType,
    this.bookedFrom,
    this.bookedTo,
    this.items,
  });

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      id: json['id'] as String?,
      bookingCode: json['booking_code'] as String?,
      bookedBy: json['booked_by'] as String?,
      contact: json['contact'] as String?,
      familyCode: json['family_code'] as String?,
      event: json['event'] as String?,
      description: json['description'] as String?,
      bookingType: json['bookin_type'] as String?,
      bookedFrom: json['bookedFrom'] != null
          ? DateTime.parse(json['booked_from'] as String)
          : null,
      bookedTo: json['booked_to'] != null
          ? DateTime.parse(json['booked_to'] as String)
          : null,
      items: json['items'] as List<String>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_code': bookingCode,
      'booked_by': bookedBy,
      'contact': contact,
      'family_code': familyCode,
      'event': event,
      'description': description,
      'booking_type': bookingType,
      'booked_from': bookedFrom,
      'booked_to': bookedTo,
      'items': items,
    };
  }
}
