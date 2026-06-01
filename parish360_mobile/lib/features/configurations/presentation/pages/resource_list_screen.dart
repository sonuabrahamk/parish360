import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/error/api_exception.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/resource_info.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/resources/resources_info_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/resources/resources_list_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/pages/resource_info_screen.dart';

class ResourceListScreen extends ConsumerWidget {
  const ResourceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resourcesListAsync = ref.watch(resourcesListControllerProvider);

    bool canCreate = ref
        .read(authControllerProvider.notifier)
        .canCreate('configurations');
    bool canDelete = ref
        .read(authControllerProvider.notifier)
        .canDelete('configurations');
    bool canEdit = ref
        .read(authControllerProvider.notifier)
        .canEdit('configurations');

    return resourcesListAsync.when(
      data: (resources) {
        return SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
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
                            'Resources Directory',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${resources.length} resource(s) found',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.white70),
                          ),
                        ],
                      ),
                      canCreate
                          ? IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResourceInfoScreen(
                                      resourceInfo: ResourceInfo(),
                                      canEdit: canEdit,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add, color: Colors.white),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: resources.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final resource = resources[index];
                      return Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResourceInfoScreen(
                                  resourceInfo: resource,
                                  canEdit: canEdit,
                                ),
                              ),
                            );
                          },
                          onLongPress: !canDelete
                              ? null
                              : () {
                                  showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Resource'),
                                      content: const Text(
                                        'Are you sure you want to delete this resource record?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              await ref
                                                  .read(
                                                    resourcesInfoControllerProvider(
                                                      resource.id ?? '',
                                                    ).notifier,
                                                  )
                                                  .deleteResourceInfo(
                                                    resource.id ?? '',
                                                  );
                                            } on DioException catch (e) {
                                              if (!context.mounted) return;
                                              showAppSnackBar(
                                                context,
                                                e.response?.data['message'] ??
                                                    'An error occurred',
                                                SnackBarType.error,
                                              );
                                              if (!context.mounted) return;
                                              Navigator.of(context).pop(true);
                                              return;
                                            } on ApiException catch (e) {
                                              if (!context.mounted) return;
                                              showAppSnackBar(
                                                context,
                                                e.message,
                                                SnackBarType.error,
                                              );
                                              if (!context.mounted) return;
                                              Navigator.of(context).pop(true);
                                              return;
                                            }

                                            ref.invalidate(
                                              resourcesListControllerProvider,
                                            );
                                            if (!context.mounted) return;
                                            showAppSnackBar(
                                              context,
                                              'Resource record deleted',
                                              SnackBarType.success,
                                            );
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                          borderRadius: BorderRadius.circular(16),
                          splashColor: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(12),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromRGBO(0, 0, 0, 0.04),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          resource.name ?? 'Unnamed Resource',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                fontWeight: FontWeight.w800,
                                              ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          resource.description?.isNotEmpty ==
                                                  true
                                              ? resource.description!
                                              : 'No description provided',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.black87),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Capacity: ${resource.capacity ?? 'N/A'} | Amount: ${resource.amount != null
                                              ? resource.currency != null
                                                    ? '${resource.currency} ${resource.amount}'
                                                    : ''
                                              : 'N/A'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
