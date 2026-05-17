import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/families/domain/entities/blessing_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/blessings/blessing_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/blessings_info_screen.dart';
import 'package:parish360_mobile/features/families/presentation/pages/calendar_date_widget.dart';

class BlessingsListScreen extends ConsumerWidget {
  final String familyId;
  const BlessingsListScreen({super.key, required this.familyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blessingsList = ref.watch(blessingListControllerProvider(familyId));

    return blessingsList.when(
      data: (blessings) {
        if (blessings.isEmpty) {
          return const Center(
            child: Text(
              'No blessings found.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Blessings History'),
            backgroundColor: Colors.transparent,
            titleTextStyle: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: false,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1, thickness: 1),
            ),
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: AppTheme.primaryColor),
                onSelected: (value) {
                  BlessingInfo newBlessing = BlessingInfo(
                    date: DateTime.now(),
                    priest: '',
                    reason: '',
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlessingsInfoScreen(
                        familyId: familyId,
                        blessingInfo: newBlessing,
                      ),
                    ),
                  );
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Add Info',
                    child: Text('Add Information'),
                  ),
                ],
              ),
            ],
          ),
          body: ListView.separated(
            // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            itemCount: blessings.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 1,
              color: AppTheme.primaryColor,
            ),
            itemBuilder: (context, index) {
              final blessing = blessings[index];

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlessingsInfoScreen(
                        familyId: familyId,
                        blessingInfo: blessing,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 90,
                        child: CalendarDateWidget(
                          date: blessing.date ?? DateTime.now(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blessing.priest?.trim().isNotEmpty == true
                                    ? blessing.priest!
                                    : 'Priest not specified',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const Divider(height: 4, thickness: 1),
                              Text(
                                blessing.reason?.trim().isNotEmpty == true
                                    ? blessing.reason!
                                    : 'No blessing reason available.',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.6,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
