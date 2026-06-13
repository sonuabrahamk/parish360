import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/parish/parish_info_controller.dart';

class ParishDrawer extends ConsumerWidget {
  final List<String> parishes;

  const ParishDrawer({super.key, required this.parishes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parishInfoAsync = ref.watch(parishInfoControllerProvider);
    final colors = Theme.of(context).colorScheme;

    return parishInfoAsync.when(
      data: (parishInfo) => Drawer(
        backgroundColor: colors.primary,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SafeArea(
              top: false,
              child: Column(
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
                    parishInfo.name ?? "No Parish Assigned",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(color: colors.secondary, thickness: 2),

                  Expanded(
                    child: ListTile(
                      title: Text(
                        parishes.isEmpty
                            ? "No Parish Assigned"
                            : parishes.first,
                      ),
                      selected: true,
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
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
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      await ref.read(authControllerProvider.notifier).logout();
                      if (context.mounted) {
                        context.go("/login");
                      }
                    },
                  ),
                  SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error loading parish info')),
    );
  }
}
