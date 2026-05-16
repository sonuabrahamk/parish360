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
      data: (data) => SingleChildScrollView(
        child: Column(
          children: [
            ...data.map(
              (sacrament) => SacramentInfoScreen(
                familyId: widget.familyId,
                memberId: widget.memberId,
                sacrament: sacrament,
              ),
            ),
            ?_draftSacramentExists
                ? SacramentInfoScreen(
                    familyId: widget.familyId,
                    memberId: widget.memberId,
                    sacrament: _draftSacrament,
                    onSaved: () => _removeDraftSacrament(_draftSacrament),
                  )
                : null,
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _addDraftSacrament,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                  ),
                  child: const Text('Add Sacrament'),
                ),
              ),
            ),
          ],
        ),
      ),
      error: (error, stack) =>
          Center(child: Text('Error loading sacraments: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
