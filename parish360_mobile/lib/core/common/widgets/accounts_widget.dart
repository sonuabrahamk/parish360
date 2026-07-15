import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/account_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/accounts/account_list_controler.dart';

class AccountsWidget extends ConsumerWidget {
  final TextEditingController accountController;
  final bool isEditing;
  final bool isRequired;

  const AccountsWidget({
    super.key,
    required this.accountController,
    required this.isEditing,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountListControllerProvider);

    return accountsAsync.when(
      data: (accounts) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DropdownButtonFormField<String>(
            initialValue: accountController.text.isNotEmpty
                ? accountController.text
                : null,
            items: accounts.map((AccountInfo account) {
              return DropdownMenuItem<String>(
                value: account.id,
                child: Text(account.name ?? ''),
              );
            }).toList(),
            onChanged: isEditing
                ? (value) {
                    if (value != null) {
                      accountController.text = value;
                    }
                  }
                : null,
            decoration: const InputDecoration(
              labelText: 'Account',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'Account is required';
              }
              return null;
            },
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error loading accounts'),
    );
  }
}
