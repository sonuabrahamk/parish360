import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/dashboard/presentation/controllers/dashboard_controllers.dart';

class StatementsScreen extends ConsumerStatefulWidget {
  const StatementsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StatementsScreenState();
}

class _StatementsScreenState extends ConsumerState<StatementsScreen> {
  late final TextEditingController _searchController;
  String selectedPeriod = 'week';
  String startDate = DateTime.now().toString().split(' ')[0];
  String endDate = DateTime.now().toString().split(' ')[0];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(statementSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void findStartAndEndDuration(String period) {
    DateTime today = DateTime.now();
    DateTime from = DateTime.now();
    DateTime to = DateTime.now();
    switch (period) {
      case 'week':
        int diffToMonday = today.weekday == 1 ? 1 : 1 - today.weekday;
        from = today.add(Duration(days: diffToMonday));
        to = from.add(Duration(days: 6));
        break;
      case 'month':
        int diffToMonth = today.day - 30;
        from = today.add(Duration(days: diffToMonth));
        to = today;
        break;
      case 'year':
        String year = today.year.toString();
        from = DateTime.parse('$year-01-01');
        to = DateTime.parse('$year-12-31');
        break;
    }
    setState(() {
      startDate = from.toString().split(' ')[0];
      endDate = to.toString().split(' ')[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final statementsAsync = ref.watch(
      statementInfoControllerProvider(startDate, endDate),
    );
    final searchQuery = ref.watch(statementSearchQueryProvider);
    final filteredStatements = ref.watch(
      filteredStatementInfoControllerProvider(searchQuery, startDate, endDate),
    );

    return statementsAsync.when(
      data: (statements) => SizedBox.expand(
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
                          'Account Statements',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Showing ${filteredStatements.length} of ${statements.length} statements',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  'Select a range',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: DropdownButtonFormField(
                                  initialValue: 'week',
                                  items: [
                                    DropdownMenuItem(
                                      value: 'week',
                                      child: Text('Current week'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'month',
                                      child: Text('Current month'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'year',
                                      child: Text('Current year'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    findStartAndEndDuration(value ?? '');
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                        ),
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
                    ref
                        .read(statementSearchQueryProvider.notifier)
                        .update(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search members...',
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
                  itemCount: filteredStatements.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final statement = filteredStatements[index];
                    return Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${statement.accountName}',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Date : ${statement.date.toString()}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey.shade600),
                                ),
                                const SizedBox(height: 4),
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
      error: (e, st) => Center(child: Text('Error loading statements')),
    );
  }
}
