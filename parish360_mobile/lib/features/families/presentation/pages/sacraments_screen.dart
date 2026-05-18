import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/features/families/domain/entities/sacrament_info.dart';
import 'package:parish360_mobile/features/families/presentation/controllers/member/sacrament_list_controller.dart';
import 'package:parish360_mobile/features/families/presentation/pages/sacrament_info_screen.dart';

class SacramentsScreen extends ConsumerStatefulWidget {
  final String familyId;
  final String memberId;

  const SacramentsScreen({
    super.key,
    required this.familyId,
    required this.memberId,
  });

  @override
  ConsumerState<SacramentsScreen> createState() => _SacramentsScreenState();
}

class _SacramentsScreenState extends ConsumerState<SacramentsScreen> {
  bool _draftSacramentExists = false;
  final SacramentInfo _draftSacrament = SacramentInfo();

  void _addDraftSacrament() {
    setState(() {
      _draftSacramentExists = true;
    });
  }

  void _removeDraftSacrament(SacramentInfo sacrament) {
    setState(() {
      _draftSacramentExists = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sacraments = ref.watch(
      sacramentListControllerProvider(widget.familyId, widget.memberId),
    );

    return sacraments.when(
      data: (data) => SizedBox.expand(
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
                          'Sacraments',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${data.length} sacrament(s)',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _addDraftSacrament,
                      icon: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: data.length + (_draftSacramentExists ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < data.length) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SacramentInfoScreen(
                          familyId: widget.familyId,
                          memberId: widget.memberId,
                          sacrament: data[index],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SacramentInfoScreen(
                          familyId: widget.familyId,
                          memberId: widget.memberId,
                          sacrament: _draftSacrament,
                          onSaved: () => _removeDraftSacrament(_draftSacrament),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stack) =>
          Center(child: Text('Error loading sacraments: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
