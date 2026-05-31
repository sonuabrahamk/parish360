import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/core/common/widgets/contact_widget.dart';
import 'package:parish360_mobile/core/common/widgets/section_form_group.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/parish_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/parish/parish_info_controller.dart';

class ParishInfoScreen extends ConsumerStatefulWidget {
  const ParishInfoScreen({super.key});

  @override
  ConsumerState<ParishInfoScreen> createState() => _ParishInfoScreenState();
}

class _ParishInfoScreenState extends ConsumerState<ParishInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _denominationController = TextEditingController();
  final TextEditingController _patronController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _foundedDateController = TextEditingController();
  final TextEditingController _timezoneController = TextEditingController();
  final TextEditingController _defaultCurrencyController =
      TextEditingController();
  final TextEditingController _addressLocationController =
      TextEditingController();
  final TextEditingController _addressCityController = TextEditingController();
  final TextEditingController _addressStateController = TextEditingController();
  final TextEditingController _addressCountryController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _denominationController.dispose();
    _patronController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _foundedDateController.dispose();
    _timezoneController.dispose();
    _defaultCurrencyController.dispose();
    _addressLocationController.dispose();
    _addressCityController.dispose();
    _addressStateController.dispose();
    _addressCountryController.dispose();
    super.dispose();
  }

  void initializeParishInfo(ParishInfo parishInfo) {
    _nameController.text = parishInfo.name ?? '';
    _denominationController.text = parishInfo.denomination ?? '';
    _patronController.text = parishInfo.patron ?? '';
    _contactController.text = parishInfo.contact ?? '';
    _emailController.text = parishInfo.email ?? '';
    _foundedDateController.text =
        (parishInfo.foundedDate?.toString().split(' ')[0]) ??
        DateTime.now().toString().split(' ')[0];
    _timezoneController.text = parishInfo.timezone ?? '';
    _defaultCurrencyController.text = parishInfo.currency ?? '';
    _addressLocationController.text = parishInfo.place?.location ?? '';
    _addressCityController.text = parishInfo.place?.city ?? '';
    _addressStateController.text = parishInfo.place?.state ?? '';
    _addressCountryController.text = parishInfo.place?.country ?? '';
  }

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveParishInfo() async {
    if (_formKey.currentState?.validate() == false) {
      return;
    }
    final updatedInfo = ParishInfo(
      name: _nameController.text,
      denomination: _denominationController.text,
      patron: _patronController.text,
      contact: _contactController.text,
      email: _emailController.text,
      foundedDate: DateTime.tryParse(_foundedDateController.text),
      timezone: _timezoneController.text,
      currency: _defaultCurrencyController.text,
      place: Place(
        location: _addressLocationController.text,
        city: _addressCityController.text,
        state: _addressStateController.text,
        country: _addressCountryController.text,
      ),
    );
    try {
      await ref
          .read(parishInfoControllerProvider.notifier)
          .updateParishInfo(updatedInfo);
      if (!mounted) return;
      showAppSnackBar(
        context,
        'Parish info updated successfully',
        SnackBarType.success,
      );
      _toggleEditing();
    } catch (e) {
      showAppSnackBar(
        context,
        'Error updating Parish info: $e',
        SnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final parishInfoAsync = ref.watch(parishInfoControllerProvider);

    bool canEdit = ref
        .read(authControllerProvider.notifier)
        .canEdit('configurations');

    return parishInfoAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(
          'Error loading Parish info: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      data: (parishInfo) {
        initializeParishInfo(parishInfo);
        return Scaffold(
          appBar: AppBar(
            title: Text(parishInfo.name ?? 'Parish Info'),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1, thickness: 1),
            ),
            actions: canEdit && !isEditing
                ? [
                    IconButton(
                      icon: Icon(Icons.edit, color: AppTheme.primaryColor),
                      onPressed: _toggleEditing,
                      tooltip: 'Edit',
                    ),
                  ]
                : [
                    IconButton(
                      icon: Icon(Icons.check, color: AppTheme.primaryColor),
                      onPressed: _saveParishInfo,
                      tooltip: 'Save',
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: AppTheme.primaryColor),
                      onPressed: _toggleEditing,
                      tooltip: 'Cancel',
                    ),
                  ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        readOnly: !isEditing,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Parish name is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUnfocus,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _denominationController,
                        decoration: const InputDecoration(
                          labelText: 'Denomination',
                        ),
                        readOnly: !isEditing,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _patronController,
                        decoration: const InputDecoration(labelText: 'Patron'),
                        readOnly: !isEditing,
                      ),
                      const SizedBox(height: 12),
                      ContactWidget(
                        controller: _contactController,
                        isEditing: isEditing,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        readOnly: !isEditing,
                        validator: (value) =>
                            (value != null &&
                                value.isNotEmpty &&
                                !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                            ? 'Enter a valid email'
                            : null,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _foundedDateController,
                        decoration: const InputDecoration(
                          labelText: 'Founded Date',
                        ),
                        readOnly: !isEditing,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _timezoneController,
                        decoration: const InputDecoration(
                          labelText: 'Timezone',
                        ),
                        readOnly: !isEditing,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _defaultCurrencyController,
                        decoration: const InputDecoration(
                          labelText: 'Default Currency',
                        ),
                        readOnly: !isEditing,
                      ),
                      const SizedBox(height: 5),
                      SectionFormGroup(
                        title: 'Address',
                        children: [
                          TextFormField(
                            controller: _addressLocationController,
                            decoration: const InputDecoration(
                              labelText: 'Location',
                            ),
                            readOnly: !isEditing,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _addressCityController,
                            decoration: const InputDecoration(
                              labelText: 'City',
                            ),
                            readOnly: !isEditing,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _addressStateController,
                            decoration: const InputDecoration(
                              labelText: 'State',
                            ),
                            readOnly: !isEditing,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _addressCountryController,
                            decoration: const InputDecoration(
                              labelText: 'Country',
                            ),
                            readOnly: !isEditing,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
