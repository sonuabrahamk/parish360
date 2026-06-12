import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:parish360_mobile/features/bookings/domain/entities/booking_info.dart';

class BookingsCard extends ConsumerWidget {
  final BookingInfo booking;

  const BookingsCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: Theme.of(context).colorScheme.primary.withAlpha(12),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(0, 0, 0, 0.04),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.resource?.name ?? '',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Booked By : ${booking.bookedBy}',
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey.shade600),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Contact : ${booking.contact}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey.shade600,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    booking.bookedFrom == null
                                        ? '-'
                                        : DateFormat(
                                            'yyyy-MM-dd hh:mma',
                                          ).format(booking.bookedFrom!),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey.shade600,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    booking.bookedTo == null
                                        ? '-'
                                        : DateFormat(
                                            'yyyy-MM-dd hh:mma',
                                          ).format(booking.bookedTo!),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Payment',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor(
                                    booking.paymentStatus ?? '',
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  booking.paymentStatus ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    backgroundColor: statusColor(
                                      booking.paymentStatus ?? '',
                                    ),
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor(booking.status ?? ''),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  booking.status ?? '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    backgroundColor: statusColor(
                                      booking.status ?? '',
                                    ),
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'in-progress':
        return Colors.yellow.shade800;
      case 'completed':
      case 'confirmed':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
