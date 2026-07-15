import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/accounts_widget.dart';
import 'package:parish360_mobile/core/common/widgets/amount_widget.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/common/widgets/section_form_group.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/payments/data/providers/payment_providers.dart';
import 'package:parish360_mobile/features/payments/domain/entities/payment_info.dart';
import 'package:parish360_mobile/features/payments/presentation/controllers/payment_list_controller.dart';

class PaymentInfoScreen extends ConsumerStatefulWidget {
  final PaymentInfo paymentInfo;

  const PaymentInfoScreen({super.key, required this.paymentInfo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends ConsumerState<PaymentInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _typeController;
  late TextEditingController _dateController;
  late TextEditingController _bookingCodeController;
  late TextEditingController _familyCodeController;
  late TextEditingController _paidToController;
  late TextEditingController _payeeController;
  late TextEditingController _accountController;
  late TextEditingController _amountController;
  late TextEditingController _currencyController;
  late TextEditingController _descriptionController;
  late TextEditingController _paymentModeController;
  late TextEditingController _subcriptionFromController;
  late TextEditingController _subcriptionToController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(
      text: widget.paymentInfo.type ?? 'BOOKING',
    );
    _dateController = TextEditingController(
      text: widget.paymentInfo.createdAt == null
          ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
          : '${widget.paymentInfo.createdAt?.year.toString()}-${widget.paymentInfo.createdAt?.month.toString().padLeft(2, '0')}-${widget.paymentInfo.createdAt?.day.toString().padLeft(2, '0')}',
    );
    _bookingCodeController = TextEditingController(
      text: widget.paymentInfo.bookingCode,
    );
    _familyCodeController = TextEditingController(
      text: widget.paymentInfo.familyCode,
    );
    _paidToController = TextEditingController(text: widget.paymentInfo.paidTo);
    _payeeController = TextEditingController(text: widget.paymentInfo.payee);
    _accountController = TextEditingController(
      text: widget.paymentInfo.accountId,
    );
    _amountController = TextEditingController(
      text: widget.paymentInfo.amount == null
          ? "0"
          : widget.paymentInfo.amount.toString(),
    );
    _currencyController = TextEditingController(
      text: widget.paymentInfo.currency,
    );
    _descriptionController = TextEditingController(
      text: widget.paymentInfo.description,
    );
    _paymentModeController = TextEditingController(
      text: widget.paymentInfo.paymentMode,
    );
    _subcriptionFromController = TextEditingController(
      text: widget.paymentInfo.subscriptionFrom == null
          ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
          : '${widget.paymentInfo.subscriptionFrom?.year.toString()}-${widget.paymentInfo.subscriptionFrom?.month.toString().padLeft(2, '0')}-${widget.paymentInfo.subscriptionFrom?.day.toString().padLeft(2, '0')}',
    );
    _subcriptionToController = TextEditingController(
      text: widget.paymentInfo.subscriptionTo == null
          ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
          : '${widget.paymentInfo.subscriptionTo?.year.toString()}-${widget.paymentInfo.subscriptionTo?.month.toString().padLeft(2, '0')}-${widget.paymentInfo.subscriptionTo?.day.toString().padLeft(2, '0')}',
    );
  }

  @override
  void dispose() {
    _typeController.dispose();
    _dateController.dispose();
    _bookingCodeController.dispose();
    _familyCodeController.dispose();
    _paidToController.dispose();
    _payeeController.dispose();
    _accountController.dispose();
    _amountController.dispose();
    _currencyController.dispose();
    _descriptionController.dispose();
    _paymentModeController.dispose();
    _subcriptionFromController.dispose();
    _subcriptionToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canCreate = ref
        .read(authControllerProvider.notifier)
        .canCreate('payments');
    final canEdit =
        canCreate ||
        ref.read(authControllerProvider.notifier).canEdit('payments');

    final paymentOptions = {
      "BOOKING": "BOOKING",
      "DONATION": "DONATION",
      "SUBSCRIPTION": "SUBSCRIPTION",
      "MASS_COLLECTION": "MASS_COLLECTION",
      "OFFERRINGS": "OFFERRINGS",
    };

    final paymentModeOptions = {
      "CASH": "Cash",
      "UPI": "UPI Payment",
      "CARD": "Card Payment",
    };

    return Scaffold(
      appBar: AppBar(
        title: widget.paymentInfo.id == null
            ? const Text('Make new Payment')
            : const Text('Payment Information'),
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 16,
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                initialValue: _typeController.text.isNotEmpty
                    ? _typeController.text
                    : 'BOOKING',
                items: paymentOptions.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                onChanged: widget.paymentInfo.id == null
                    ? (value) {
                        if (value != null) {
                          setState(() {
                            _typeController.text = value;
                          });
                        }
                      }
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Account',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Payment type is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DateWidget(
                controller: _dateController,
                label: 'Date',
                isEditing: widget.paymentInfo.id == null,
              ),
              TextFormField(
                controller: _paidToController,
                decoration: const InputDecoration(
                  labelText: 'Paid To',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the person paid to';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _payeeController,
                decoration: const InputDecoration(
                  labelText: 'Payee',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of the person paid by';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _familyCodeController,
                decoration: const InputDecoration(
                  labelText: 'Family Code',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              if (_typeController.text.toUpperCase() == 'BOOKING')
                TextFormField(
                  controller: _bookingCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Booking Code',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: widget.paymentInfo.id != null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter booking code';
                    }
                    return null;
                  },
                ),
              if (_typeController.text.toUpperCase() == 'SUBSCRIPTION')
                SectionFormGroup(
                  title: 'Subscription Details',
                  children: [
                    DateWidget(
                      controller: _subcriptionFromController,
                      label: 'From',
                      isEditing: widget.paymentInfo.id == null,
                    ),
                    DateWidget(
                      controller: _subcriptionToController,
                      label: 'To',
                      isEditing: widget.paymentInfo.id == null,
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              AmountWidget(
                currencyController: _currencyController,
                amountController: _amountController,
                isEditing: canEdit,
                isRequired: true,
              ),
              AccountsWidget(
                accountController: _accountController,
                isEditing: canEdit,
                isRequired: true,
              ),
              DropdownButtonFormField<String>(
                initialValue: _paymentModeController.text.isNotEmpty
                    ? _paymentModeController.text.toUpperCase()
                    : 'CASH',
                items: paymentModeOptions.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    _paymentModeController.text = value;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Payment Mode',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Payment mode is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              if (canEdit)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _savePayment(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Make Payment'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _savePayment() async {
    if (!_formKey.currentState!.validate()) {}
    final updatedPayment = PaymentInfo(
      createdAt: DateTime.parse(_dateController.text),
      type: _typeController.text,
      paidTo: _paidToController.text,
      payee: _payeeController.text,
      familyCode: _familyCodeController.text,
      bookingCode: _bookingCodeController.text,
      subscriptionFrom: DateTime.parse(_subcriptionFromController.text),
      subscriptionTo: DateTime.parse(_subcriptionToController.text),
      description: _descriptionController.text,
      amount: double.parse(_amountController.text),
      currency: _currencyController.text,
      accountId: _accountController.text,
      paymentMode: _paymentModeController.text,
    );

    try {
      if (widget.paymentInfo.id == null) {
        await ref
            .read(paymentsRepositoryProvider)
            .createPayment(updatedPayment);
        ref.invalidate(paymentListControllerProvider);

        if (mounted) {
          showAppSnackBar(
            context,
            'Payment created successfully',
            SnackBarType.success,
          );
        }
      } else {
        await ref
            .read(paymentsRepositoryProvider)
            .updatePayment(widget.paymentInfo.id!, updatedPayment);
        ref.invalidate(paymentListControllerProvider);

        if (mounted) {
          showAppSnackBar(
            context,
            'Payment updated successfully',
            SnackBarType.success,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
          context,
          'Error saving payment info',
          SnackBarType.error,
        );
      }
    } finally {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
