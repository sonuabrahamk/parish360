import 'package:flutter/material.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/minister_info.dart';

class MinisterFormControllers {
  // Minister Form Controller
  final ministerPriestController = TextEditingController();
  final ministerTitleController = TextEditingController();

  MinisterFormControllers(MinisterInfo ministerInfo) {
    ministerPriestController.text = ministerInfo.priest ?? '';
    ministerTitleController.text = ministerInfo.title ?? '';
  }

  void dispose() {
    ministerPriestController.dispose();
    ministerTitleController.dispose();
  }
}
