import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parish360_mobile/core/common/entities/god_parent.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/core/common/widgets/date_widget.dart';
import 'package:parish360_mobile/core/utils/ceremonies_constants.dart';
import 'package:parish360_mobile/core/utils/snack_bar_helper.dart';
import 'package:parish360_mobile/core/utils/theme.dart';
import 'package:parish360_mobile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/afterlife_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ceremony_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/minister_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ordination_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/witness_info.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/afterlife_form_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/ceremony_info_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/ceremony_list_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/ceremony_member_form_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/minister_form_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/ordination_form_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/controllers/witness_form_controller.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/widgets/afterlife_info_widget.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/widgets/minister_info_widget.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/widgets/ordination_info_widget.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/widgets/personal_info.dart';
import 'package:parish360_mobile/features/ceremonies/presentation/widgets/witness_info_widget.dart';

class CeremonyInfoScreen extends ConsumerStatefulWidget {
  final CeremonyInfo ceremonyInfo;

  const CeremonyInfoScreen({super.key, required this.ceremonyInfo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CeremonyInfoScreenState();
}

class _CeremonyInfoScreenState extends ConsumerState<CeremonyInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late String ceremonyType;

  late CeremonyFormControllers ceremonyFormControllers;
  late CeremonyMemberFormController personalDetailsFormControllers;
  MinisterFormControllers? ministerFormControllers;
  CeremonyMemberFormController? spouseDetailsFormControllers;
  WitnessFormControllers? witness1FormControllers;
  WitnessFormControllers? witness2FormControllers;
  AfterlifeFormControllers? afterlifeFormControllers;
  OrdinationFormControllers? ordinationFormControllers;

  @override
  void initState() {
    super.initState();

    setState(() {
      ceremonyType = widget.ceremonyInfo.type ?? '';
    });

    ceremonyFormControllers = CeremonyFormControllers(widget.ceremonyInfo);
    ministerFormControllers = MinisterFormControllers(
      widget.ceremonyInfo.minister ?? MinisterInfo(),
    );
    personalDetailsFormControllers =
        CeremonyMemberFormController.fromCeremonyInfo(widget.ceremonyInfo);
    spouseDetailsFormControllers = widget.ceremonyInfo.spouse != null
        ? CeremonyMemberFormController.fromSpouseInfo(
            widget.ceremonyInfo.spouse!,
          )
        : null;
    witness1FormControllers = WitnessFormControllers(
      widget.ceremonyInfo.witness1 ?? WitnessInfo(),
    );
    witness2FormControllers = WitnessFormControllers(
      widget.ceremonyInfo.witness2 ?? WitnessInfo(),
    );
    afterlifeFormControllers = AfterlifeFormControllers(
      widget.ceremonyInfo.afterlife ?? AfterlifeInfo(),
    );
    ordinationFormControllers = OrdinationFormControllers(
      widget.ceremonyInfo.ordination ?? OrdinationInfo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canCreate = ref
        .read(authControllerProvider.notifier)
        .canCreate('ceremonies');
    final canEdit =
        canCreate ||
        ref.read(authControllerProvider.notifier).canEdit('ceremonies');
    return Scaffold(
      appBar: AppBar(
        title: widget.ceremonyInfo.id == null
            ? const Text('Create Ceremony Information')
            : const Text('Ceremony Information'),
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                initialValue: ceremonyType == ''
                    ? null
                    : ceremonyFormControllers.ceremonyTypeController.text,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
                items: ceremonyTypeOptions.entries
                    .map(
                      (entry) => DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                    )
                    .toList(),
                onChanged: widget.ceremonyInfo.id == null
                    ? (String? newValue) {
                        ceremonyFormControllers.ceremonyTypeController.value =
                            TextEditingValue(text: newValue ?? '');
                        setState(() {
                          ceremonyType = newValue ?? '';
                        });
                      }
                    : null,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a relationship';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 12),
              DateWidget(
                controller: ceremonyFormControllers.dateController,
                label: 'Date',
                isEditing: (widget.ceremonyInfo.id == null),
              ),
              DropdownButtonFormField<String>(
                initialValue: widget.ceremonyInfo.parishioner == true
                    ? 'true'
                    : 'false',
                decoration: const InputDecoration(
                  labelText: 'Parishioner',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem<String>(value: 'true', child: Text('Yes')),
                  DropdownMenuItem<String>(value: 'false', child: Text('No')),
                ],
                onChanged: widget.ceremonyInfo.id == null
                    ? (String? newValue) {
                        ceremonyFormControllers.parishionerController.value =
                            TextEditingValue(text: newValue ?? '');
                      }
                    : null,
              ),
              const SizedBox(height: 12),
              MinisterInfoWidget(
                ministerFormControllers: ministerFormControllers,
                isEditable: canEdit,
              ),
              PersonalInfo(
                personalDetailsFormControllers: personalDetailsFormControllers,
                title: 'Personal Information',
                isEditable: canEdit,
              ),
              if (ceremonyType.toLowerCase() == 'marriage') ...[
                PersonalInfo(
                  personalDetailsFormControllers:
                      spouseDetailsFormControllers ??
                      CeremonyMemberFormController(),
                  title: 'Spouse Information',
                  isEditable: canEdit,
                ),
                WitnessInfoWidget(
                  witnessFormControllers:
                      witness1FormControllers ??
                      WitnessFormControllers(WitnessInfo()),
                  witnessTitle: 'Witness 1 Information',
                  isEditable: canEdit,
                ),
                WitnessInfoWidget(
                  witnessFormControllers:
                      witness2FormControllers ??
                      WitnessFormControllers(WitnessInfo()),
                  witnessTitle: 'Witness 2 Information',
                  isEditable: canEdit,
                ),
              ],
              if (ceremonyType.toLowerCase() == 'ordination') ...[
                OrdinationInfoWidget(
                  ordinationFormControllers:
                      ordinationFormControllers ??
                      OrdinationFormControllers(OrdinationInfo()),
                  isEditable: canEdit,
                ),
              ],
              if (ceremonyType.toLowerCase() == 'requiem') ...[
                AfterlifeInfoWidget(
                  afterlifeFormControllers:
                      afterlifeFormControllers ??
                      AfterlifeFormControllers(AfterlifeInfo()),
                  isEditable: canEdit,
                ),
              ],
              if (canEdit)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _saveBlessingInfo(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Save Information'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBlessingInfo() async {
    if (_formKey.currentState?.validate() ?? false) {
      CeremonyInfo newCeremonyInfo = CeremonyInfo(
        type: ceremonyFormControllers.ceremonyTypeController.text.trim(),
        date: DateTime.parse(
          ceremonyFormControllers.dateController.text.trim(),
        ),
        parishioner:
            ceremonyFormControllers.parishionerController.text.trim() == 'true',
        minister: MinisterInfo(
          priest: ceremonyFormControllers.priestController.text.trim(),
          title: ceremonyFormControllers.ministerTitleController.text.trim(),
        ),
        name: personalDetailsFormControllers.nameController.text.trim(),
        baptismName: personalDetailsFormControllers.baptismNameController.text
            .trim(),
        father: personalDetailsFormControllers.fatherController.text.trim(),
        mother: personalDetailsFormControllers.motherController.text.trim(),
        dob: DateTime.parse(
          personalDetailsFormControllers.dobController.text.trim(),
        ),
        maritalStatus: personalDetailsFormControllers
            .maritalStatusController
            .text
            .trim(),
        email: personalDetailsFormControllers.emailController.text.trim(),
        contact: personalDetailsFormControllers.contactController.text.trim(),
        address: personalDetailsFormControllers.addressController.text.trim(),
        remarks: personalDetailsFormControllers.remarksController.text.trim(),
        godFather: GodParent(
          name: personalDetailsFormControllers
              .personalGodFatherNameController
              .text
              .trim(),
          baptismName: personalDetailsFormControllers
              .personalGodFatherBaptismNameController
              .text
              .trim(),
          parish: personalDetailsFormControllers
              .personalGodFatherParishController
              .text
              .trim(),
          contact: personalDetailsFormControllers
              .personalGodFatherContactController
              .text
              .trim(),
        ),
        godMother: GodParent(
          name: personalDetailsFormControllers
              .personalGodMotherNameController
              .text
              .trim(),
          baptismName: personalDetailsFormControllers
              .personalGodMotherBaptismNameController
              .text
              .trim(),
          parish: personalDetailsFormControllers
              .personalGodMotherParishController
              .text
              .trim(),
          contact: personalDetailsFormControllers
              .personalGodMotherContactController
              .text
              .trim(),
        ),
        birthPlace: Place(
          city: personalDetailsFormControllers
              .personalBirthPlaceCityController
              .text
              .trim(),
          state: personalDetailsFormControllers
              .personalBirthPlaceStateController
              .text
              .trim(),
          country: personalDetailsFormControllers
              .personalBirthPlaceCountryController
              .text
              .trim(),
        ),
        spouse: spouseDetailsFormControllers?.toCeremonyMemberInfo(),
        witness1: witness1FormControllers?.toWitnessInfo(),
        witness2: witness2FormControllers?.toWitnessInfo(),
        afterlife: afterlifeFormControllers?.toAfterlifeInfo(),
        ordination: ordinationFormControllers?.toOrdinationInfo(),
      );
      try {
        if (widget.ceremonyInfo.id == null) {
          await ref
              .read(
                ceremonyInfoControllerProvider(
                  widget.ceremonyInfo.id ?? '',
                ).notifier,
              )
              .createCeremony(newCeremonyInfo);
          ref.invalidate(ceremonyListControllerProvider);

          if (mounted) {
            showAppSnackBar(
              context,
              'Ceremony info created successfully',
              SnackBarType.success,
            );
          }
        } else {
          await ref
              .read(
                ceremonyInfoControllerProvider(
                  widget.ceremonyInfo.id ?? '',
                ).notifier,
              )
              .updateCeremony(widget.ceremonyInfo.id ?? '', newCeremonyInfo);

          ref.invalidate(ceremonyListControllerProvider);

          if (mounted) {
            showAppSnackBar(
              context,
              'Ceremony info updated successfully',
              SnackBarType.success,
            );
          }
        }
      } catch (e) {
        if (mounted) {
          showAppSnackBar(
            context,
            'Error saving ceremony info',
            SnackBarType.error,
          );
        }
      } finally {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } else {
      showAppSnackBar(
        context,
        'Please fill in all required fields',
        SnackBarType.warning,
      );
    }
  }
}

class CeremonyFormControllers {
  // Ceremony Details
  final ceremonyTypeController = TextEditingController();
  final dateController = TextEditingController();
  final parishionerController = TextEditingController();
  final priestController = TextEditingController();
  final ministerTitleController = TextEditingController();

  CeremonyFormControllers(CeremonyInfo ceremonyInfo) {
    ceremonyTypeController.text = ceremonyInfo.type ?? '';
    dateController.text = ceremonyInfo.date == null
        ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
        : '${ceremonyInfo.date?.year.toString()}-${ceremonyInfo.date?.month.toString().padLeft(2, '0')}-${ceremonyInfo.date?.day.toString().padLeft(2, '0')}';
    parishionerController.text = ceremonyInfo.parishioner == true
        ? 'true'
        : 'false';
    priestController.text = ceremonyInfo.minister?.priest ?? '';
    ministerTitleController.text = ceremonyInfo.minister?.title ?? '';
  }

  void dispose() {
    ceremonyTypeController.dispose();
    dateController.dispose();
    parishionerController.dispose();
    priestController.dispose();
    ministerTitleController.dispose();
  }
}
