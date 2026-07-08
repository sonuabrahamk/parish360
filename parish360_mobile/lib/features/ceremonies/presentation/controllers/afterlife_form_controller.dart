import 'package:flutter/material.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/afterlife_info.dart';

class AfterlifeFormControllers {
  // Afterlife details
  final dateOfDeathController = TextEditingController();
  final deathPlaceCityController = TextEditingController();
  final deathPlaceStateController = TextEditingController();
  final deathPlaceCountryController = TextEditingController();
  final cemetryNameController = TextEditingController();
  final cemetryPlaceCityController = TextEditingController();
  final cemetryPlaceStateController = TextEditingController();
  final cemetryPlaceCountryController = TextEditingController();

  AfterlifeFormControllers(AfterlifeInfo afterlifeInfo) {
    dateOfDeathController.text = afterlifeInfo.dod == null
        ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
        : '${afterlifeInfo.dod?.year.toString()}-${afterlifeInfo.dod?.month.toString().padLeft(2, '0')}-${afterlifeInfo.dod?.day.toString().padLeft(2, '0')}';
    deathPlaceCityController.text = afterlifeInfo.placeOfDeath?.city ?? '';
    deathPlaceStateController.text = afterlifeInfo.placeOfDeath?.state ?? '';
    deathPlaceCountryController.text =
        afterlifeInfo.placeOfDeath?.country ?? '';
    cemetryNameController.text = afterlifeInfo.cemetery ?? '';
    cemetryPlaceCityController.text = afterlifeInfo.cemeteryPlace?.city ?? '';
    cemetryPlaceStateController.text = afterlifeInfo.cemeteryPlace?.state ?? '';
    cemetryPlaceCountryController.text =
        afterlifeInfo.cemeteryPlace?.country ?? '';
  }

  void dispose() {
    dateOfDeathController.dispose();
    deathPlaceCityController.dispose();
    deathPlaceStateController.dispose();
    deathPlaceCountryController.dispose();
    cemetryNameController.dispose();
    cemetryPlaceCityController.dispose();
    cemetryPlaceStateController.dispose();
    cemetryPlaceCountryController.dispose();
  }

  AfterlifeInfo toAfterlifeInfo() {
    return AfterlifeInfo(
      dod: DateTime.tryParse(dateOfDeathController.text.trim()),
      placeOfDeath: Place(
        city: deathPlaceCityController.text.trim(),
        state: deathPlaceStateController.text.trim(),
        country: deathPlaceCountryController.text.trim(),
      ),
      cemetery: cemetryNameController.text.trim(),
      cemeteryPlace: Place(
        city: cemetryPlaceCityController.text.trim(),
        state: cemetryPlaceStateController.text.trim(),
        country: cemetryPlaceCountryController.text.trim(),
      ),
    );
  }
}
