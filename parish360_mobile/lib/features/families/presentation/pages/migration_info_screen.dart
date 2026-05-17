import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/features/families/domain/entities/migration_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/migration_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/migration_list_controller.dart';

class MigrationInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final String memberId;
  final MigrationInfo migration;
  final VoidCallback? onSaved;

  const MigrationInfoScreen({
    super.key,
    required this.familyId,
    required this.memberId,
    required this.migration,
    this.onSaved,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MigrationInfoScreenState();
}

class _MigrationInfoScreenState extends ConsumerState<MigrationInfoScreen> {
  bool _isExpanded = false;

  late final _migratedOn = TextEditingController(
    text: widget.migration.migratedOn != null
        ? '${widget.migration.migratedOn!.day}/${widget.migration.migratedOn!.month}/${widget.migration.migratedOn!.year}'
        : '',
  );
  late final _comment = TextEditingController(
    text: widget.migration.comment ?? '',
  );
  late final _parish = TextEditingController(
    text: widget.migration.parish ?? '',
  );
  late final _address = TextEditingController(
    text: widget.migration.address ?? '',
  );
  late final _status = TextEditingController(
    text: widget.migration.status ?? '',
  );
  late final _returnDate = TextEditingController(
    text: widget.migration.returnDate != null
        ? '${widget.migration.returnDate!.day}/${widget.migration.returnDate!.month}/${widget.migration.returnDate!.year}'
        : '',
  );
  late final _placeLocation = TextEditingController(
    text: widget.migration.place?.location ?? '',
  );
  late final _placeCity = TextEditingController(
    text: widget.migration.place?.city ?? '',
  );
  late final _placeState = TextEditingController(
    text: widget.migration.place?.state ?? '',
  );
  late final _placeCountry = TextEditingController(
    text: widget.migration.place?.country ?? '',
  );

  @override
  void dispose() {
    _migratedOn.dispose();
    _comment.dispose();
    _parish.dispose();
    _address.dispose();
    _status.dispose();
    _returnDate.dispose();
    _placeLocation.dispose();
    _placeCity.dispose();
    _placeState.dispose();
    _placeCountry.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.migration.migratedOn ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
      child: Column(
        children: [
          // Card Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Sacrament Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.migration.migratedOn != null
                              ? 'Migration on: ${widget.migration.migratedOn!.day}/${widget.migration.migratedOn!.month}/${widget.migration.migratedOn!.year}'
                              : 'New Migration Information',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expand/Collapse Icon
                  IconButton(
                    visualDensity: VisualDensity(
                      vertical: VisualDensity.minimumDensity,
                    ),
                    onPressed: () => _deleteMigrationInfo(context),
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                  // Expand/Collapse Icon
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          // Expandable Content
          if (_isExpanded)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _migratedOn,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Migrated On',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context, _migratedOn),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _comment,
                    decoration: const InputDecoration(
                      labelText: 'Comment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _parish,
                    decoration: const InputDecoration(
                      labelText: 'Parish',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _address,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _returnDate,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Return Date',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context, _returnDate),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Place Information
                  const Text(
                    'Place Information',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _placeLocation,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _placeCity,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _placeState,
                    decoration: const InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _placeCountry,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _saveMigrationInfo(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        textStyle: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _saveMigrationInfo(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    // Parse dates for migration and return
    DateTime? migrationOn;
    DateTime? returnDate;
    if (_migratedOn.text.isNotEmpty) {
      try {
        final parts = _migratedOn.text.split('/');
        if (parts.length == 3) {
          migrationOn = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      } catch (e) {
        // Invalid date format, keep as null
      }
    }
    if (_returnDate.text.isNotEmpty) {
      try {
        final parts = _returnDate.text.split('/');
        if (parts.length == 3) {
          returnDate = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      } catch (e) {
        // Invalid date format, keep as null
      }
    }
    // Implement save logic here, e.g., call a provider to update the sacrament info in the backend
    MigrationInfo updatedInfo = MigrationInfo(
      id: widget.migration.id,
      migratedOn: migrationOn,
      returnDate: returnDate,
      comment: _comment.text,
      address: _address.text,
      parish: _parish.text,
      place: Place(
        location: _placeLocation.text,
        city: _placeCity.text,
        state: _placeState.text,
        country: _placeCountry.text,
      ),
    );

    final isNewMigration = widget.migration.id == null;
    try {
      if (isNewMigration) {
        await ref
            .read(
              migrationInfoControllerProvider(
                widget.familyId,
                widget.memberId,
                widget.migration.id ?? '',
              ).notifier,
            )
            .createMigration(widget.familyId, widget.memberId, updatedInfo);
        ref.invalidate(
          migrationListControllerProvider(widget.familyId, widget.memberId),
        );
      } else {
        await ref
            .read(
              migrationInfoControllerProvider(
                widget.familyId,
                widget.memberId,
                widget.migration.id ?? '',
              ).notifier,
            )
            .updateMigration(
              widget.familyId,
              widget.memberId,
              widget.migration.id ?? '',
              updatedInfo,
            );
      }

      if (!mounted) return;
      widget.onSaved?.call();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            isNewMigration
                ? 'Migration created successfully'
                : 'Migration info updated successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to save migration info: $e')),
      );
    }
  }

  Future<void> _deleteMigrationInfo(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final isNewMigration = widget.migration.id == null;
    try {
      if (isNewMigration) {
        widget.onSaved?.call();
        return;
      }
      await ref
          .read(
            migrationInfoControllerProvider(
              widget.familyId,
              widget.memberId,
              widget.migration.id ?? '',
            ).notifier,
          )
          .deleteMigration(
            widget.familyId,
            widget.memberId,
            widget.migration.id ?? '',
          );
      ref.invalidate(
        migrationListControllerProvider(widget.familyId, widget.memberId),
      );
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Migration deleted successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to delete migration: $e')),
      );
    }
  }
}
