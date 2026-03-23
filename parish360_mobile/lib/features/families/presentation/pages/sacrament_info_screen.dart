import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/domain/entities/sacrament_info.dart';

class SacramentInfoScreen extends ConsumerStatefulWidget {
  final String familyId;
  final String memberId;
  final SacramentInfo sacrament;

  const SacramentInfoScreen({
    super.key,
    required this.familyId,
    required this.memberId,
    required this.sacrament,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SacramentInfoScreenState();
}

class _SacramentInfoScreenState extends ConsumerState<SacramentInfoScreen> {

  late final _type = TextEditingController(text: widget.sacrament.type ?? '');
  late final _priest = TextEditingController(text: widget.sacrament.priest ?? '');
  late final _parish = TextEditingController(text: widget.sacrament.parish ?? '');
  late final _date = TextEditingController(
    text: widget.sacrament.date != null
        ? '${widget.sacrament.date!.day}/${widget.sacrament.date!.month}/${widget.sacrament.date!.year}'
        : '',
  );
  late final _placeLocation = TextEditingController(text: widget.sacrament.place?.location ?? '');
  late final _placeCity = TextEditingController(text: widget.sacrament.place?.city ?? '');
  late final _placeState = TextEditingController(text: widget.sacrament.place?.state ?? '');
  late final _placeCountry = TextEditingController(text: widget.sacrament.place?.country ?? '');

  @override
  void dispose() {
    _type.dispose();
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
    return ExpansionTile(
      title: Text(widget.sacrament.type ?? 'Unknown Sacrament'),
      subtitle: Text(_date.text.isNotEmpty ? 'Date: ${_date.text}' : 'Date: Unknown'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _type,
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _date,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _priest,
                decoration: const InputDecoration(labelText: 'Priest'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _parish,
                decoration: const InputDecoration(labelText: 'Parish'),
              ),
              const SizedBox(height: 16),
              const Text('Place Information:', style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                controller: _placeLocation,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _placeCity,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _placeState,
                decoration: const InputDecoration(labelText: 'State'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _placeCountry,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}