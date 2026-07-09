import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/widgets/accounts_widget.dart';
import 'package:parish360_mobile/core/common/widgets/amount_widget.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/expenses/domain/entities/expense_info.dart';

class ExpenseInfoScreen extends ConsumerStatefulWidget {
  final ExpenseInfo expense;

  const ExpenseInfoScreen({super.key, required this.expense});

  @override
  ConsumerState<ExpenseInfoScreen> createState() => _ExpenseInfoScreenState();
}

class _ExpenseInfoScreenState extends ConsumerState<ExpenseInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _dateController;
  late TextEditingController _paidToController;
  late TextEditingController _paidByController;
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late TextEditingController _currencyController;
  late TextEditingController _accountController;
  late TextEditingController _paymentMethodController;

  @override
  void initState() {
    super.initState();
    _paidToController = TextEditingController(text: widget.expense.paidTo);
    _paidByController = TextEditingController(text: widget.expense.paidBy);
    _descriptionController = TextEditingController(
      text: widget.expense.description,
    );
    _amountController = TextEditingController(
      text: widget.expense.amount?.toString() ?? '',
    );
    _currencyController = TextEditingController(text: widget.expense.currency);
    _accountController = TextEditingController(text: widget.expense.accountId);
    _paymentMethodController = TextEditingController(text: 'CASH');
    _dateController = TextEditingController(
      text: widget.expense.date == null
          ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
          : '${widget.expense.date?.year.toString()}-${widget.expense.date?.month.toString().padLeft(2, '0')}-${widget.expense.date?.day.toString().padLeft(2, '0')}',
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _paidToController.dispose();
    _paidByController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _currencyController.dispose();
    _accountController.dispose();
    _paymentMethodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canCreate = ref
        .read(authControllerProvider.notifier)
        .canCreate('expenses');
    final canEdit =
        canCreate ||
        ref.read(authControllerProvider.notifier).canEdit('expenses');

    return Scaffold(
      appBar: AppBar(
        title: widget.expense.id == null
            ? const Text('Create Expense Information')
            : const Text('Expense Information'),
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
              DateWidget(
                controller: _dateController,
                label: 'Date',
                isEditing: canEdit,
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
                controller: _paidByController,
                decoration: const InputDecoration(
                  labelText: 'Paid By',
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
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
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
              TextFormField(
                controller: _paymentMethodController,
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              if (canEdit)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _saveBlessingInfo(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Save Information'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBlessingInfo() {
    if (_formKey.currentState!.validate()) {
      final updatedExpense = ExpenseInfo(
        id: widget.expense.id,
        paidTo: _paidToController.text,
        paidBy: _paidByController.text,
        description: _descriptionController.text,
        amount: double.parse(_amountController.text),
      );

      // Here you would typically call a method to save the updated expense info
      // For example, you might use a provider or a service to handle the save operation

      Navigator.pop(context, updatedExpense);
    }
  }
}
