import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/presentation/pages/associations_screen.dart';
import 'package:parish360_mobile/features/parish-year/presentation/widgets/parish_year_info_screen.dart';

class ParishYearRecordScreen extends ConsumerWidget {
  final ParishYearInfo parishYearInfo;

  const ParishYearRecordScreen({super.key, required this.parishYearInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          isScrollable: false,
          tabAlignment: TabAlignment.fill,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
          tabs: [
            Tab(icon: Icon(Icons.church), text: 'Parish Year Info'),
            Tab(icon: Icon(Icons.groups), text: 'Associations'),
          ],
        ),
        body: TabBarView(
          children: [
            ParishYearInfoScreen(parishYearInfo: parishYearInfo),
            AssociationsScreen(parishYearId: parishYearInfo.id ?? ''),
            // Center(child: Text('Payments Page')),
          ],
        ),
      ),
    );
  }
}
