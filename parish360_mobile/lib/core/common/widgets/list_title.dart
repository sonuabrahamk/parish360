import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';

class ListTitle extends ConsumerWidget {
  final String title;
  final String subTitle;
  final String module;
  final VoidCallback onCreatePressed;

  const ListTitle({
    super.key,
    required this.module,
    required this.subTitle,
    required this.title,
    required this.onCreatePressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canCreate = ref
        .read(authControllerProvider.notifier)
        .canCreate(module);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subTitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              canCreate
                  ? IconButton(
                      onPressed: onCreatePressed,
                      icon: const Icon(Icons.add, color: Colors.white),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
