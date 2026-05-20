import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/domain/entities/subscription_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/subscriptions/subscription_list_controller.dart';

class SubscriptionsScreen extends ConsumerWidget {
  final String familyId;
  const SubscriptionsScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionsList = ref.watch(
      subscriptionListControllerProvider(familyId),
    );

    return subscriptionsList.when(
      data: (subscriptions) {
        if (subscriptions.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subscription Calendar',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${subscriptions.length} paid month(s)',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${subscriptions.length}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Total paid',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return MonthlySubscriptionsWidget(subscriptions: subscriptions);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}

class MonthlySubscriptionsWidget extends StatelessWidget {
  final List<SubscriptionInfo> subscriptions;

  const MonthlySubscriptionsWidget({super.key, required this.subscriptions});

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  int? _monthIndex(SubscriptionInfo subscription) {
    final rawMonth = subscription.month?.trim() ?? '';
    if (rawMonth.isEmpty) return null;

    final monthIndex = int.tryParse(rawMonth);
    if (monthIndex != null && monthIndex >= 1 && monthIndex <= 12) {
      return monthIndex;
    }

    final lowerMonth = rawMonth.toLowerCase();
    final nameIndex = _monthNames.indexWhere(
      (month) => month.toLowerCase() == lowerMonth,
    );
    if (nameIndex >= 0) {
      return nameIndex + 1;
    }

    return null;
  }

  int? _yearValue(SubscriptionInfo subscription) {
    final rawYear = subscription.year?.trim() ?? '';
    final yearIndex = int.tryParse(rawYear);
    if (yearIndex != null && yearIndex > 0) {
      return yearIndex;
    }

    final date = subscription.updatedAt ?? subscription.createdAt;
    if (date != null) {
      return date.year;
    }
    return null;
  }

  DateTime _subscriptionDate(SubscriptionInfo subscription) {
    return subscription.updatedAt ??
        subscription.createdAt ??
        _monthYearDate(subscription) ??
        DateTime(1900);
  }

  DateTime? _monthYearDate(SubscriptionInfo subscription) {
    final year = _yearValue(subscription);
    final month = _monthIndex(subscription);
    if (year != null && month != null) {
      return DateTime(year, month);
    }
    return null;
  }

  String _formatAmount(SubscriptionInfo subscription) {
    final amount = subscription.amount ?? 0.0;
    final currency = subscription.currency?.trim().isNotEmpty == true
        ? subscription.currency!.toUpperCase()
        : 'USD';
    return '$currency ${amount.toStringAsFixed(2)}';
  }

  Map<int, Map<int, SubscriptionInfo>> _groupSubscriptionsByYearAndMonth() {
    final groups = <int, Map<int, SubscriptionInfo>>{};

    for (final subscription in subscriptions) {
      final year = _yearValue(subscription);
      final month = _monthIndex(subscription);
      if (year == null || month == null) continue;

      groups.putIfAbsent(year, () => {});
      final existing = groups[year]![month];
      if (existing == null ||
          _subscriptionDate(
            subscription,
          ).isAfter(_subscriptionDate(existing))) {
        groups[year]![month] = subscription;
      }
    }

    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = subscriptions.fold<double>(
      0,
      (total, subscription) => total + (subscription.amount ?? 0.0),
    );

    final groupedSubscriptions = _groupSubscriptionsByYearAndMonth();
    final sortedYears = groupedSubscriptions.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    final currency = subscriptions.first.currency?.trim().isNotEmpty == true
        ? subscriptions.first.currency!.toUpperCase()
        : 'USD';

    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subscription Calendar',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${subscriptions.length} paid month(s)',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$currency ${totalAmount.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Total paid',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: sortedYears.length,
                itemBuilder: (context, yearIndex) {
                  final year = sortedYears[yearIndex];
                  final monthlyMap = groupedSubscriptions[year]!;
                  final paidCount = monthlyMap.length;
                  final missedCount = 12 - paidCount;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              year.toString(),
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '$paidCount paid • $missedCount pending',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(0, 0, 0, 0.04),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: List.generate(12, (monthIndex) {
                            final month = monthIndex + 1;
                            final paidSubscription = monthlyMap[month];
                            final paid = paidSubscription != null;
                            final monthLabel = _monthNames[monthIndex];
                            final amountLabel = paid
                                ? _formatAmount(paidSubscription)
                                : 'Pending';
                            final color = paid
                                ? Colors.green.shade50
                                : Colors.grey.shade100;
                            final borderColor = paid
                                ? Colors.green.shade200
                                : Colors.grey.shade300;

                            return SizedBox(
                              width: 100,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      monthLabel.substring(0, 3),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: paid
                                            ? Colors.green.shade900
                                            : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      amountLabel,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: paid
                                            ? Colors.green.shade900
                                            : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          paid
                                              ? Icons.check_circle
                                              : Icons.error_outline,
                                          size: 18,
                                          color: paid
                                              ? Colors.green.shade700
                                              : Colors.grey.shade600,
                                        ),
                                        Text(
                                          paid ? 'Paid' : 'Pending',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: paid
                                                ? Colors.green.shade700
                                                : Colors.grey.shade700,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      ...yearIndex != sortedYears.length - 1
                          ? [const SizedBox(height: 16)]
                          : [],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
