import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parish360_mobile/features/auth/data/providers/module_index_providers.dart';
import 'package:parish360_mobile/features/auth/domain/entities/module_info.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.25,
              minChildSize: 0.25,
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

                // Grid with 4 equal columns; items keep same visual style as top bar
                return GridView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 1,
                  ),
                  itemCount: remainingItems.length,
                  itemBuilder: (context, index) {
                    final selectedIndex = ref.watch(moduleIndexProvider);
                    final item = remainingItems[index];
                    final globalIndex = index + 3; // remaining items start at index 3
                    final isSelected = selectedIndex == globalIndex;

                    return GestureDetector(
                      onTap: () {
                        context.pop();
                        ref.read(moduleIndexProvider.notifier).setIndex(globalIndex);
                        context.go(item.route);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 36,
                              width: 36,
                              child: Icon(
                                item.icon,
                                size: 28,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Flexible(
                              child: Text(
                                item.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(moduleIndexProvider);
    final navItems = ref.read(authControllerProvider.notifier).getAllowedModules();

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
