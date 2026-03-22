import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/features/auth/data/providers/auth_providers.dart';

class ParishDrawer extends ConsumerWidget {
  final List<String> parishes;

  const ParishDrawer({super.key, required this.parishes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(parishProvider);
    final colors = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: colors.primary,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: AssetImage("assets/images/parishlogo.png"),
                  width: constraints.maxWidth * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 12),
              Text(
                selected,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(
                color: colors.secondary,
                thickness: 2,
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: parishes.length,
                  itemBuilder: (context, index) {
                    final parish = parishes[index];
                    final isSelected = parish == selected;

                    return ListTile(
                      title: Text(parish),
                      selected: isSelected,
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                      },
                    );
                  },
                ),
              ),

              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: Colors.white,
                leading: const Icon(Icons.person),
                title: const Text(
                  'My Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  context.go("/families");
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 12),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: Colors.white,
                leading: const Icon(Icons.logout),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Warning'),
                      content: const Text('Logout has to be implemented.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
