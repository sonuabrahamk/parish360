import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/features/families/domain/entities/sacrament_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/sacrament_info_controller.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/sacrament_list_controller.dart';

class SacramentInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final String memberId;
  final SacramentInfo sacrament;
  final VoidCallback? onSaved;

  const SacramentInfoScreen({
    super.key,
    required this.familyId,
    required this.memberId,
    required this.sacrament,
    this.onSaved,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SacramentInfoScreenState();
}

class _SacramentInfoScreenState extends ConsumerState<SacramentInfoScreen> {
  bool _isExpanded = false;

  String? _selectedType;
  late final _priest = TextEditingController(
    text: widget.sacrament.priest ?? '',
  );
  late final _parish = TextEditingController(
    text: widget.sacrament.parish ?? '',
  );
  late final _date = TextEditingController(
    text: widget.sacrament.date != null
        ? '${widget.sacrament.date!.day}/${widget.sacrament.date!.month}/${widget.sacrament.date!.year}'
        : '',
  );
  late final _placeLocation = TextEditingController(
    text: widget.sacrament.place?.location ?? '',
  );
  late final _placeCity = TextEditingController(
    text: widget.sacrament.place?.city ?? '',
  );
  late final _placeState = TextEditingController(
    text: widget.sacrament.place?.state ?? '',
  );
  late final _placeCountry = TextEditingController(
    text: widget.sacrament.place?.country ?? '',
  );

  final List<String> _sacramentTypes = [
    'baptism',
    'confirmation',
    'eucharist',
    'marriage',
    'ordination',
    'anointing_the_sick',
    'holy_communion',
  ];

  @override
  void dispose() {
    _priest.dispose();
    _parish.dispose();
    _date.dispose();
    _placeLocation.dispose();
    _placeCity.dispose();
    _placeState.dispose();
    _placeCountry.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.sacrament.date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _date.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.grey.shade200),
      ),
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
                          _getSacramentTitle(widget.sacrament.type),
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
                    onPressed: () => _deleteSacramentInfo(context),
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
                  // Basic Information
                  const Text(
                    'Basic Information',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedType ?? widget.sacrament.type,
                    decoration: const InputDecoration(
                      labelText: 'Sacrament Type',
                    ),
                    items: _sacramentTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(_getSacramentTitle(value)),
                      );
                    }).toList(),
                    onChanged:
                        _getSacramentTitle(widget.sacrament.type) ==
                            'Sacrament Type'
                        ? (String? newValue) {
                            setState(() {
                              _selectedType = newValue;
                            });
                          }
                        : null,
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _date,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: _priest,
                    decoration: const InputDecoration(
                      labelText: 'Priest',
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
                      onPressed: () => _saveSacramentInfo(context),
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

  Future<void> _saveSacramentInfo(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    // Parse date of sacrament from the text field
    DateTime? dateOfSacrament;
    if (_date.text.isNotEmpty) {
      try {
        final parts = _date.text.split('/');
        if (parts.length == 3) {
          dateOfSacrament = DateTime(
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
    SacramentInfo updatedInfo = SacramentInfo(
      id: widget.sacrament.id,
      type: _selectedType ?? widget.sacrament.type,
      date: dateOfSacrament,
      priest: _priest.text,
      parish: _parish.text,
      place: Place(
        location: _placeLocation.text,
        city: _placeCity.text,
        state: _placeState.text,
        country: _placeCountry.text,
      ),
    );

    final isNewSacrament = widget.sacrament.id == null;
    try {
      if (isNewSacrament) {
        await ref
            .read(
              sacramentInfoControllerProvider(
                widget.familyId,
                widget.memberId,
                widget.sacrament.id ?? '',
              ).notifier,
            )
            .createSacrament(widget.familyId, widget.memberId, updatedInfo);
        ref.invalidate(
          sacramentListControllerProvider(widget.familyId, widget.memberId),
        );
      } else {
        await ref
            .read(
              sacramentInfoControllerProvider(
                widget.familyId,
                widget.memberId,
                widget.sacrament.id ?? '',
              ).notifier,
            )
            .updateSacrament(
              widget.familyId,
              widget.memberId,
              widget.sacrament.id ?? '',
              updatedInfo,
            );
      }

      if (!mounted) return;
      widget.onSaved?.call();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            isNewSacrament
                ? 'Sacrament created successfully'
                : 'Sacrament info updated successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to save sacrament info: $e')),
      );
    }
  }

  Future<void> _deleteSacramentInfo(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final isNewSacrament = widget.sacrament.id == null;
    try {
      if (isNewSacrament) {
        widget.onSaved?.call();
        return;
      }
      await ref
          .read(
            sacramentInfoControllerProvider(
              widget.familyId,
              widget.memberId,
              widget.sacrament.id ?? '',
            ).notifier,
          )
          .deleteSacrament(
            widget.familyId,
            widget.memberId,
            widget.sacrament.id ?? '',
          );
      ref.invalidate(
        sacramentListControllerProvider(widget.familyId, widget.memberId),
      );
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Sacrament deleted successfully')),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Failed to delete sacrament: $e')),
      );
    }
  }

  String _getSacramentTitle(String? type) {
    switch (type?.toLowerCase()) {
      case 'baptism':
        return 'Baptism';
      case 'confirmation':
        return 'Holy Confirmation';
      case 'eucharist':
        return 'Holy Eucharist';
      case 'marriage':
        return 'Holy Matrimony';
      case 'ordination':
        return 'Holy Ordination';
      case 'anointing_the_sick':
        return 'Annointing of the Sick';
      case 'holy_communion':
        return 'Holy Communion';
      default:
        return 'Sacrament Type';
    }
  }
}
