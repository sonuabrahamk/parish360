import 'package:flutter/material.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ordination_info.dart';

class OrdinationFormControllers {
  // Ordination Details
  final religiousOrderController = TextEditingController();
  final seminaryNameController = TextEditingController();
  final seminaryCityController = TextEditingController();
  final seminaryStateController = TextEditingController();
  final seminaryCountryController = TextEditingController();
  final previousOrdinationTypeController = TextEditingController();
  final previousOrdinationDateController = TextEditingController();
  final previousOrdinationCityController = TextEditingController();
  final previousOrdinationStateController = TextEditingController();
  final previousOrdinationCountryController = TextEditingController();

  OrdinationFormControllers(OrdinationInfo ordinationInfo) {
    religiousOrderController.text = ordinationInfo.religiousOrder ?? '';
    seminaryNameController.text = ordinationInfo.seminaryName ?? '';
    seminaryCityController.text = ordinationInfo.seminaryAddress?.city ?? '';
    seminaryStateController.text = ordinationInfo.seminaryAddress?.state ?? '';
    seminaryCountryController.text =
        ordinationInfo.seminaryAddress?.country ?? '';
    previousOrdinationTypeController.text =
        ordinationInfo.previousOrdinationType ?? '';
    previousOrdinationDateController.text =
        ordinationInfo.previousOrdinationDate == null
        ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
        : '${ordinationInfo.previousOrdinationDate?.year.toString()}-${ordinationInfo.previousOrdinationDate?.month.toString().padLeft(2, '0')}-${ordinationInfo.previousOrdinationDate?.day.toString().padLeft(2, '0')}';
    previousOrdinationCityController.text =
        ordinationInfo.previousOrdinationPlace?.city ?? '';
    previousOrdinationStateController.text =
        ordinationInfo.previousOrdinationPlace?.state ?? '';
    previousOrdinationCountryController.text =
        ordinationInfo.previousOrdinationPlace?.country ?? '';
  }

  void dispose() {
    religiousOrderController.dispose();
    seminaryNameController.dispose();
    seminaryCityController.dispose();
    seminaryStateController.dispose();
    seminaryCountryController.dispose();
    previousOrdinationTypeController.dispose();
    previousOrdinationDateController.dispose();
    previousOrdinationCityController.dispose();
    previousOrdinationStateController.dispose();
    previousOrdinationCountryController.dispose();
  }

  OrdinationInfo toOrdinationInfo() {
    return OrdinationInfo(
      religiousOrder: religiousOrderController.text.trim(),
      seminaryName: seminaryNameController.text.trim(),
      seminaryAddress: Place(
        city: seminaryCityController.text.trim(),
        state: seminaryStateController.text.trim(),
        country: seminaryCountryController.text.trim(),
      ),
      previousOrdinationType: previousOrdinationTypeController.text.trim(),
      previousOrdinationDate: DateTime.tryParse(
        previousOrdinationDateController.text.trim(),
      ),
      previousOrdinationPlace: Place(
        city: previousOrdinationCityController.text.trim(),
        state: previousOrdinationStateController.text.trim(),
        country: previousOrdinationCountryController.text.trim(),
      ),
    );
  }
}
