import 'package:flutter/material.dart';
import 'package:parish360_mobile/core/common/entities/god_parent.dart';
import 'package:parish360_mobile/core/common/entities/place.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/ceremony_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/church_info.dart';
import 'package:parish360_mobile/features/ceremonies/domain/entities/spouse_info.dart';

class CeremonyMemberFormController {
  // Personal Details
  // Information
  final nameController = TextEditingController();
  final baptismNameController = TextEditingController();
  final dobController = TextEditingController();
  final fatherController = TextEditingController();
  final motherController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final remarksController = TextEditingController();

  // Personal Details
  // Birth Place information
  final personalBirthPlaceCityController = TextEditingController();
  final personalBirthPlaceStateController = TextEditingController();
  final personalBirthPlaceCountryController = TextEditingController();

  // Personal Details
  // Parish Information
  final personalParishFamilyCodeController = TextEditingController();
  final personalParishParishNameController = TextEditingController();
  final personalParishDioceseNameController = TextEditingController();
  final personalParishLocationCityController = TextEditingController();
  final personalParishLocationStateController = TextEditingController();
  final personalParishLocationCountryController = TextEditingController();

  // Personal Details
  // God Father Information
  final personalGodFatherNameController = TextEditingController();
  final personalGodFatherBaptismNameController = TextEditingController();
  final personalGodFatherParishController = TextEditingController();
  final personalGodFatherContactController = TextEditingController();

  // Personal Details
  // God Mother Information
  final personalGodMotherNameController = TextEditingController();
  final personalGodMotherBaptismNameController = TextEditingController();
  final personalGodMotherParishController = TextEditingController();
  final personalGodMotherContactController = TextEditingController();

  CeremonyMemberFormController();

  CeremonyMemberFormController.fromCeremonyInfo(CeremonyInfo ceremonyInfo) {
    nameController.text = ceremonyInfo.name ?? '';
    baptismNameController.text = ceremonyInfo.baptismName ?? '';
    fatherController.text = ceremonyInfo.father ?? '';
    motherController.text = ceremonyInfo.mother ?? '';
    maritalStatusController.text = ceremonyInfo.maritalStatus ?? '';
    dobController.text = ceremonyInfo.dob == null
        ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
        : '${ceremonyInfo.dob?.year.toString()}-${ceremonyInfo.dob?.month.toString().padLeft(2, '0')}-${ceremonyInfo.dob?.day.toString().padLeft(2, '0')}';
    emailController.text = ceremonyInfo.email ?? '';
    contactController.text = ceremonyInfo.contact ?? '';
    addressController.text = ceremonyInfo.address ?? '';
    remarksController.text = ceremonyInfo.remarks ?? '';

    // birth place information
    personalBirthPlaceCityController.text = ceremonyInfo.birthPlace?.city ?? '';
    personalBirthPlaceStateController.text =
        ceremonyInfo.birthPlace?.state ?? '';
    personalBirthPlaceCountryController.text =
        ceremonyInfo.birthPlace?.country ?? '';

    // parish information
    personalParishFamilyCodeController.text =
        ceremonyInfo.church?.familyCode ?? '';
    personalParishParishNameController.text = ceremonyInfo.church?.church ?? '';
    personalParishDioceseNameController.text =
        ceremonyInfo.church?.diocese ?? '';
    personalParishLocationCityController.text =
        ceremonyInfo.church?.churchLocation?.city ?? '';
    personalParishLocationStateController.text =
        ceremonyInfo.church?.churchLocation?.state ?? '';
    personalParishLocationCountryController.text =
        ceremonyInfo.church?.churchLocation?.country ?? '';

    // god father information
    personalGodFatherNameController.text = ceremonyInfo.godFather?.name ?? '';
    personalGodFatherBaptismNameController.text =
        ceremonyInfo.godFather?.baptismName ?? '';
    personalGodFatherParishController.text =
        ceremonyInfo.godFather?.parish ?? '';
    personalGodFatherContactController.text =
        ceremonyInfo.godFather?.contact ?? '';

    // god mother information
    personalGodMotherNameController.text = ceremonyInfo.godMother?.name ?? '';
    personalGodMotherBaptismNameController.text =
        ceremonyInfo.godMother?.baptismName ?? '';
    personalGodMotherParishController.text =
        ceremonyInfo.godMother?.parish ?? '';
    personalGodMotherContactController.text =
        ceremonyInfo.godMother?.contact ?? '';
  }

  CeremonyMemberFormController.fromSpouseInfo(SpouseInfo spouseInfo) {
    nameController.text = spouseInfo.spouseName ?? '';
    baptismNameController.text = spouseInfo.spouseBaptismName ?? '';
    fatherController.text = spouseInfo.spouseFather ?? '';
    motherController.text = spouseInfo.spouseMother ?? '';
    maritalStatusController.text = spouseInfo.spouseMaritalStatus ?? '';
    dobController.text = spouseInfo.spouseDob == null
        ? '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}'
        : '${spouseInfo.spouseDob?.year.toString()}-${spouseInfo.spouseDob?.month.toString().padLeft(2, '0')}-${spouseInfo.spouseDob?.day.toString().padLeft(2, '0')}';
    emailController.text = spouseInfo.spouseEmail ?? '';
    contactController.text = spouseInfo.spouseContact ?? '';
    addressController.text = spouseInfo.spouseAddress ?? '';

    // birth place information
    personalBirthPlaceCityController.text = spouseInfo.birthPlace?.city ?? '';
    personalBirthPlaceStateController.text = spouseInfo.birthPlace?.state ?? '';
    personalBirthPlaceCountryController.text =
        spouseInfo.birthPlace?.country ?? '';

    // parish information
    personalParishFamilyCodeController.text =
        spouseInfo.spouseChurch?.familyCode ?? '';
    personalParishParishNameController.text =
        spouseInfo.spouseChurch?.church ?? '';
    personalParishDioceseNameController.text =
        spouseInfo.spouseChurch?.diocese ?? '';
    personalParishLocationCityController.text =
        spouseInfo.spouseChurch?.churchLocation?.city ?? '';
    personalParishLocationStateController.text =
        spouseInfo.spouseChurch?.churchLocation?.state ?? '';
    personalParishLocationCountryController.text =
        spouseInfo.spouseChurch?.churchLocation?.country ?? '';

    // god father information
    personalGodFatherNameController.text = spouseInfo.godFather?.name ?? '';
    personalGodFatherBaptismNameController.text =
        spouseInfo.godFather?.baptismName ?? '';
    personalGodFatherParishController.text = spouseInfo.godFather?.parish ?? '';
    personalGodFatherContactController.text =
        spouseInfo.godFather?.contact ?? '';

    // god mother information
    personalGodMotherNameController.text = spouseInfo.godMother?.name ?? '';
    personalGodMotherBaptismNameController.text =
        spouseInfo.godMother?.baptismName ?? '';
    personalGodMotherParishController.text = spouseInfo.godMother?.parish ?? '';
    personalGodMotherContactController.text =
        spouseInfo.godMother?.contact ?? '';
  }

  void dispose() {
    nameController.dispose();
    baptismNameController.dispose();
    dobController.dispose();
    fatherController.dispose();
    motherController.dispose();
    maritalStatusController.dispose();
    emailController.dispose();
    contactController.dispose();
    addressController.dispose();
    remarksController.dispose();

    personalBirthPlaceCityController.dispose();
    personalBirthPlaceStateController.dispose();
    personalBirthPlaceCountryController.dispose();

    personalParishFamilyCodeController.dispose();
    personalParishParishNameController.dispose();
    personalParishDioceseNameController.dispose();
    personalParishLocationCityController.dispose();
    personalParishLocationStateController.dispose();
    personalParishLocationCountryController.dispose();

    personalGodFatherNameController.dispose();
    personalGodFatherBaptismNameController.dispose();
    personalGodFatherParishController.dispose();
    personalGodFatherContactController.dispose();

    personalGodMotherNameController.dispose();
    personalGodMotherBaptismNameController.dispose();
    personalGodMotherParishController.dispose();
    personalGodMotherContactController.dispose();
  }

  SpouseInfo toCeremonyMemberInfo() {
    return SpouseInfo(
      spouseName: nameController.text.trim(),
      spouseBaptismName: baptismNameController.text.trim(),
      spouseDob: DateTime.parse(dobController.text.trim()),
      spouseFather: fatherController.text.trim(),
      spouseMother: motherController.text.trim(),
      spouseMaritalStatus: maritalStatusController.text.trim(),
      spouseEmail: emailController.text.trim(),
      spouseContact: contactController.text.trim(),
      spouseAddress: addressController.text.trim(),
      spouseChurch: ChurchInfo(
        familyCode: personalParishFamilyCodeController.text.trim(),
        church: personalParishParishNameController.text.trim(),
        diocese: personalParishDioceseNameController.text.trim(),
        churchLocation: Place(
          city: personalParishLocationCityController.text.trim(),
          state: personalParishLocationStateController.text.trim(),
          country: personalParishLocationCountryController.text.trim(),
        ),
      ),
      godFather: GodParent(
        name: personalGodFatherNameController.text.trim(),
        baptismName: personalGodFatherBaptismNameController.text.trim(),
        parish: personalGodFatherParishController.text.trim(),
        contact: personalGodFatherContactController.text.trim(),
      ),
      godMother: GodParent(
        name: personalGodMotherNameController.text.trim(),
        baptismName: personalGodMotherBaptismNameController.text.trim(),
        parish: personalGodMotherParishController.text.trim(),
        contact: personalGodMotherContactController.text.trim(),
      ),
      birthPlace: Place(
        city: personalBirthPlaceCityController.text.trim(),
        state: personalBirthPlaceStateController.text.trim(),
        country: personalBirthPlaceCountryController.text.trim(),
      ),
    );
  }
}
