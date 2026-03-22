import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/features/auth/data/providers/auth_providers.dart';
import 'package:parish360_mobile/features/auth/data/providers/module_index_providers.dart';
import 'package:parish360_mobile/features/auth/domain/entities/module_info.dart';

class ModulesNavBar extends ConsumerWidget {
  const ModulesNavBar({super.key});

  void _showBottomDrawer(
    BuildContext context,
    List<ModuleInfo> remainingItems,
    WidgetRef ref,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              if (remainingItems.isEmpty) {
                return Center(
                  child: Text(
                    'No additional modules available',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                );
              }
              return Wrap(
                spacing: MediaQuery.of(context).size.width * 0.05,
                runSpacing: MediaQuery.of(context).size.width * 0.05,
                children: List.generate(remainingItems.length, (index) {
                  final selectedIndex = ref.watch(moduleIndexProvider);
                  final item = remainingItems[index];
                  final isSelected = (selectedIndex - 3) == index;
                  return GestureDetector(
                    onTap: () {
                      context.pop();
                      ref.read(moduleIndexProvider.notifier).setIndex(index + 3);
                      context.go(item.route);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(moduleIndexProvider);
    final navItems = ref.watch(modulesProvider);

    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length > 4 ? 4 : navItems.length, (
          index,
        ) {
          final item = navItems[index];
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              if (index == 3) {
                // More tab
                _showBottomDrawer(context, navItems.sublist(3), ref);
              } else {
                ref.read(moduleIndexProvider.notifier).setIndex(index);
                context.go(item.route);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    index == 3 ? Icons.more_horiz : item.icon,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    index == 3 ? 'More' : item.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
