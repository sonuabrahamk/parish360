import 'package:flutter/material.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/witness_info.dart';

class WitnessFormControllers {
  // Witness Form Controller
  final witnessNameController = TextEditingController();
  final witnessRelationController = TextEditingController();
  final witnessParishController = TextEditingController();
  final witnessContactController = TextEditingController();

  WitnessFormControllers(WitnessInfo witnessInfo) {
    witnessNameController.text = witnessInfo.name ?? '';
    witnessRelationController.text = witnessInfo.relation ?? '';
    witnessParishController.text = witnessInfo.parish ?? '';
    witnessContactController.text = witnessInfo.contact ?? '';
  }

  void dispose() {
    witnessNameController.dispose();
    witnessRelationController.dispose();
    witnessParishController.dispose();
    witnessContactController.dispose();
  }

  WitnessInfo toWitnessInfo() {
    return WitnessInfo(
      name: witnessNameController.text.trim(),
      relation: witnessRelationController.text.trim(),
      parish: witnessParishController.text.trim(),
      contact: witnessContactController.text.trim(),
    );
  }
}
