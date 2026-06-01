import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/configurations/presentation/controllers/services/service_list_controller.dart';

class ServiceListScreen extends ConsumerStatefulWidget {
  const ServiceListScreen({super.key});

  @override
  ConsumerState<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends ConsumerState<ServiceListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(serviceSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serviceListAsync = ref.watch(serviceListControllerProvider);
    final searchQuery = ref.watch(serviceSearchQueryProvider);
    final filteredServices = ref.watch(
      filteredServicesInfoListProvider(searchQuery),
    );

    // bool canCreate = ref
    //     .read(authControllerProvider.notifier)
    //     .canCreate('configurations');
    // bool canEdit = ref
    //     .read(authControllerProvider.notifier)
    //     .canEdit('configurations');
    bool canDelete = ref
        .read(authControllerProvider.notifier)
        .canDelete('configurations');

    return serviceListAsync.when(
      data: (services) => SizedBox.expand(
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
                          'Services Directory',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${services.length} services found',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // canCreate
                        //     ? IconButton(
                        //         onPressed: () => Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => AssociationInfoScreen(
                        //               association: AssociationInfo(),
                        //               canEdit: canCreate,
                        //             ),
                        //           ),
                        //         ),
                        //         icon: const Icon(
                        //           Icons.add,
                        //           color: Colors.white,
                        //         ),
                        //       )
                        //     : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    ref.read(serviceSearchQueryProvider.notifier).update(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by name, type or scope',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: filteredServices.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final service = filteredServices[index];
                    return Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ServiceInfoScreen(
                          //       service: service,
                          //       canEdit: canEdit,
                          //     ),
                          //   ),
                          // );
                        },
                        onLongPress: !canDelete
                            ? null
                            : () {
                                // showDialog<bool>(
                                //   context: context,
                                //   builder: (context) => AlertDialog(
                                //     title: const Text('Delete Association'),
                                //     content: const Text(
                                //       'Are you sure you want to delete this association?',
                                //     ),
                                //     actions: [
                                //       TextButton(
                                //         onPressed: () =>
                                //             Navigator.of(context).pop(false),
                                //         child: const Text('Cancel'),
                                //       ),
                                //       TextButton(
                                //         onPressed: () async {
                                //           try {
                                //             await ref
                                //                 .read(
                                //                   associationInfoControllerProvider(
                                //                     association.id ?? '',
                                //                   ).notifier,
                                //                 )
                                //                 .deleteAssociation(
                                //                   association.id ?? '',
                                //                 );
                                //           } on ApiException catch (e) {
                                //             if (!context.mounted) return;
                                //             showAppSnackBar(
                                //               context,
                                //               e.message,
                                //               SnackBarType.error,
                                //             );
                                //             Navigator.of(context).pop(true);
                                //             return;
                                //           } on DioException catch (e) {
                                //             if (!context.mounted) return;
                                //             showAppSnackBar(
                                //               context,
                                //               e.response?.data['message'] ??
                                //                   'An error occurred',
                                //               SnackBarType.error,
                                //             );
                                //             Navigator.of(context).pop(true);
                                //             return;
                                //           }
                                //           ref.invalidate(
                                //             associationListControllerProvider,
                                //           );
                                //           if (!context.mounted) return;
                                //           showAppSnackBar(
                                //             context,
                                //             'Association record deleted',
                                //             SnackBarType.success,
                                //           );
                                //           Navigator.of(context).pop(true);
                                //         },
                                //         child: const Text(
                                //           'Delete',
                                //           style: TextStyle(color: Colors.red),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // );
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      service.name?.isNotEmpty == true
                                          ? service.name!
                                          : 'Unknown Service',
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
                                      'Service Type : ${service.type ?? 'N/A'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Date : ${service.date.toString().substring(0, 10)} at ${service.startTime?.format(context) ?? 'N/A'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      service.date != null
                                          ? service.date!
                                                        .difference(
                                                          DateTime.now(),
                                                        )
                                                        .inDays <
                                                    0
                                                ? 'COMPLETED'
                                                : 'UPCOMING'
                                          : 'No date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: service.date != null
                                                ? service.date!
                                                              .difference(
                                                                DateTime.now(),
                                                              )
                                                              .inDays <
                                                          0
                                                      ? Colors.green
                                                      : Colors.orange
                                                : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
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
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error loading services')),
    );
  }
}
