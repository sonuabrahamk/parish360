import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/list_title.dart';
import 'package:parish360_mobile/features/associations/presentation/controllers/py_association_list_controller.dart';
import 'package:parish360_mobile/features/parish-year/domain/entities/parish_year_info.dart';
import 'package:parish360_mobile/features/parish-year/presentation/controllers/parish_year_list_controller.dart';
import 'package:parish360_mobile/features/parish-year/presentation/pages/associations_screen.dart';

class ParishYearAssociationsScreen extends ConsumerStatefulWidget {
  const ParishYearAssociationsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ParishYearAssociationsScreenState();
}

class _ParishYearAssociationsScreenState
    extends ConsumerState<ParishYearAssociationsScreen> {
  late final TextEditingController _parishYearIdController;

  @override
  void initState() {
    super.initState();
    _parishYearIdController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _parishYearIdController.dispose();
    super.dispose();
  }

  ParishYearInfo initializeParishYear(List<ParishYearInfo> parishYearList) {
    for (int i = 0; i < parishYearList.length; i++) {
      if (parishYearList[i].status?.toUpperCase() == 'IN-PROGRESS') {
        return parishYearList[i];
      }
    }
    return parishYearList[0];
  }

  @override
  Widget build(BuildContext context) {
    final parishYearListAsync = ref.watch(parishYearListControllerProvider);
    final pyAssociations = ref.watch(
      filteredpyAssociationsProvider(_parishYearIdController.text, ''),
    );

    return parishYearListAsync.when(
      data: (parishYearList) {
        if (parishYearList.isEmpty) {
          return const Center(child: Text('No Parish year data found'));
        }
        ParishYearInfo activeParishYear = initializeParishYear(parishYearList);
        if (_parishYearIdController.text.isEmpty) {
          _parishYearIdController.text = activeParishYear.id ?? '';
        }
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              pyAssociations.isEmpty
                  ? ListTitle(
                      module: 'parish',
                      subTitle: 'No Associations found',
                      title: 'Associations',
                      onCreatePressed: () {},
                    )
                  : ListTitle(
                      module: 'parish',
                      subTitle: 'Showing ${pyAssociations.length} associations',
                      title: 'Associations',
                      onCreatePressed: () {},
                    ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.zero,
                child: DropdownButtonFormField<String?>(
                  initialValue: _parishYearIdController.text.isEmpty
                      ? null
                      : _parishYearIdController.text,
                  items: parishYearList
                      .map(
                        (parishYear) => DropdownMenuItem<String?>(
                          value: parishYear.id,
                          child: Text(parishYear.name ?? ''),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _parishYearIdController.text = value ?? '';
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: AssociationsScreen(
                  parishYearId: _parishYearIdController.text,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(
        child: Text('Error loading parish year list to find associations'),
      ),
    );
  }
}
