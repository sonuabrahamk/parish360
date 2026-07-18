import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/bookings/presentation/widgets/date_time_widget.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/resources/resources_list_controller.dart';

class BookingCreateScreen extends ConsumerStatefulWidget {
  const BookingCreateScreen({super.key});

  @override
  ConsumerState<BookingCreateScreen> createState() =>
      _BookingCreateScreenState();
}

class _BookingCreateScreenState extends ConsumerState<BookingCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateTimeFormKey = GlobalKey<FormState>();
  int _currentStep = 0;
  final Set<String> _selectedItemIds = <String>{};

  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _eventController = TextEditingController();
  final _organizerController = TextEditingController();
  final _contactController = TextEditingController();
  final _notesController = TextEditingController();
  final _paymentMethodController = TextEditingController(text: 'Cash');
  final _cardholderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _amountController = TextEditingController(text: '1200');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _eventController.dispose();
    _organizerController.dispose();
    _contactController.dispose();
    _notesController.dispose();
    _paymentMethodController.dispose();
    _cardholderController.dispose();
    _cardNumberController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final steps = [
      'Select your dates',
      'Choose a resource',
      'Booking details',
      'Payment details',
      'Review and confirm',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create booking'),
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[_currentStep],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Complete the guided steps to reserve a parish resource for your event',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: List.generate(steps.length, (index) {
                        final isActive = index <= _currentStep;
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              right: index == steps.length - 1 ? 0 : 6,
                            ),
                            height: 6,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppTheme.secondaryColor
                                  : colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_currentStep == 0)
                        Form(
                          key: _dateTimeFormKey,
                          child: DateTimeWidget(
                            fromDate: _fromController,
                            toDate: _toController,
                          ),
                        ),
                      if (_currentStep == 1) _buildResourceStep(context),
                      if (_currentStep == 2) _buildBookingDetailsStep(context),
                      if (_currentStep == 3) _buildPaymentStep(context),
                      if (_currentStep == 4) _buildSummaryStep(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              if (_currentStep > 0)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _goBack,
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: const Text('Back'),
                  ),
                ),
              if (_currentStep > 0) const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _currentStep == 4 ? _confirmBooking : _goNext,
                  icon: Icon(
                    _currentStep == 4
                        ? Icons.check_circle_outline_rounded
                        : Icons.arrow_forward_rounded,
                  ),
                  label: Text(
                    _currentStep == 4 ? 'Confirm booking' : 'Continue',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourceStep(BuildContext context) {
    final availableResourcesAsync = ref.watch(resourcesListControllerProvider);

    return availableResourcesAsync.when(
      data: (resources) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          if (resources.isEmpty)
            Text(
              'No resources are available for the selected dates. Try a different range.',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            )
          else
            ...resources.map((resource) {
              final bool isSelected =
                  _selectedItemIds.contains(resource.id);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () => setState(
                    () => isSelected
                        ? _selectedItemIds.remove(resource.id)
                        : _selectedItemIds.add(resource.id ?? ''),
                  ),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryColor.withOpacity(0.08)
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resource.name ?? 'Resource',
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                resource.description ??
                                    'Comfortable parish facility',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${resource.currency} ${resource.amount?.toStringAsFixed(0) ?? '0'}',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primaryColor,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              resource.capacity != null ? '${resource.capacity ?? 0} seats' : '',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading resources')),
    );
  }

  Widget _buildBookingDetailsStep(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking information',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Share the event details so we can confirm the booking.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context,
                controller: _eventController,
                label: 'Event name',
                hint: 'Wedding reception',
                icon: Icons.event_rounded,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                context,
                controller: _organizerController,
                label: 'Organizer',
                hint: 'John Kamau',
                icon: Icons.person_rounded,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                context,
                controller: _contactController,
                label: 'Contact number',
                hint: '0712 123 456',
                icon: Icons.phone_rounded,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                context,
                controller: _notesController,
                label: 'Notes',
                hint: 'Decoration, catering, access requirements',
                icon: Icons.notes_rounded,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentStep(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment details',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a payment approach and confirm the expected amount.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context,
              controller: _paymentMethodController,
              label: 'Payment method',
              hint: 'Cash, M-Pesa or card',
              icon: Icons.payment_rounded,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              context,
              controller: _cardholderController,
              label: 'Account holder',
              hint: 'Jane Doe',
              icon: Icons.account_circle_rounded,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              context,
              controller: _cardNumberController,
              label: 'Reference number',
              hint: 'TX-1042',
              icon: Icons.receipt_long_rounded,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              context,
              controller: _amountController,
              label: 'Amount',
              hint: '1200',
              icon: Icons.money_rounded,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStep(BuildContext context) {
    final duration = _getDurationInDays();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Review your booking',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Confirm that the details below are correct before submitting.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            _summaryRow(
              'Dates',
              '$_formattedDate(_fromDate) - $_formattedDate(_toDate)',
            ),
            _summaryRow('Duration', '$duration day${duration == 1 ? '' : 's'}'),
            _summaryRow('Resource', _selectedItemIds.length.toString()),
            _summaryRow(
              'Event',
              _eventController.text.trim().isEmpty
                  ? 'Pending'
                  : _eventController.text.trim(),
            ),
            _summaryRow(
              'Organizer',
              _organizerController.text.trim().isEmpty
                  ? 'Pending'
                  : _organizerController.text.trim(),
            ),
            _summaryRow(
              'Contact',
              _contactController.text.trim().isEmpty
                  ? 'Pending'
                  : _contactController.text.trim(),
            ),
            _summaryRow(
              'Payment',
              _paymentMethodController.text.trim().isEmpty
                  ? 'Pending'
                  : _paymentMethodController.text.trim(),
            ),
            _summaryRow(
              'Amount',
              'KES ${_amountController.text.trim().isEmpty ? '0' : _amountController.text.trim()}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  void _goNext() {
    if (_currentStep == 0) {
      if (!_dateTimeFormKey.currentState!.validate()) {
        return;
      }
    }

    if (_currentStep == 1 && _selectedItemIds.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an available resource.')),
      );
      return;
    }

    if (_currentStep == 2) {
      if (_eventController.text.trim().isEmpty ||
          _organizerController.text.trim().isEmpty ||
          _contactController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill the booking details before continuing.'),
          ),
        );
        return;
      }
    }

    if (_currentStep == 3) {
      if (_paymentMethodController.text.trim().isEmpty ||
          _amountController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide payment details before continuing.'),
          ),
        );
        return;
      }
    }

    setState(() {
      _currentStep = (_currentStep + 1).clamp(0, 4);
    });
  }

  void _goBack() {
    setState(() {
      _currentStep = (_currentStep - 1).clamp(0, 4);
    });
  }

  Future<void> _confirmBooking() async {
    if (_paymentMethodController.text.trim().isEmpty ||
        _amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide payment details before confirming.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking request submitted successfully.')),
    );
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  int _getDurationInDays() {
    return DateTime.parse(
          _toController.text,
        ).difference(DateTime.parse(_fromController.text)).inDays +
        1;
  }

  String _formattedDate(DateTime? value) {
    if (value == null) {
      return 'Select date';
    }
    return '${value.day}/${value.month}/${value.year}';
  }
}
