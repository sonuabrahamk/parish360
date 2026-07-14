import 'package:parish360_mobile/features/associations/data/providers/py_association_providers.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/association_info.dart';
import 'package:parish360_mobile/features/families/domain/entities/family_info.dart';
import 'package:parish360_mobile/features/families/domain/entities/member_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'associate_list_controller.g.dart';

@riverpod
class AssociateListController extends _$AssociateListController {
  @override
  Future<dynamic> build(String pyAssociationId) {
    return ref
        .read(pyAssociationRepositoryProvider)
        .getAssociates(pyAssociationId);
  }
}

@riverpod
dynamic filteredAssociates(
  Ref ref,
  String pyAssociationId,
  String associationType,
  String filter,
) {
  final associatesAsync = ref.watch(
    associateListControllerProvider(pyAssociationId),
  );

  return associatesAsync.when(
    data: (associates) {
      final lowerFilter = filter.toLowerCase();
      switch (associationType.toUpperCase()) {
        case 'MEMBER':
          List<MemberInfo> members = (associates as List<dynamic>)
              .map((e) => MemberInfo.fromJson(e as Map<String, dynamic>))
              .toList();
          return members.where((member) {
            final fullName =
                '${member.firstName ?? ''} ${member.lastName ?? ''}'
                    .toLowerCase();
            final contact = member.contact.toString().toLowerCase();
            final email = member.email.toString().toLowerCase();
            final relationship = member.relationship.toString().toLowerCase();
            final father = member.father.toString().toLowerCase();
            final mother = member.mother.toString().toLowerCase();
            final dob = member.dob.toString().toLowerCase();
            final gender = member.gender.toString().toLowerCase();
            final qualification = member.qualification.toString().toLowerCase();
            final occupation = member.occupation.toString().toLowerCase();

            return fullName.contains(lowerFilter) ||
                contact.contains(lowerFilter) ||
                email.contains(lowerFilter) ||
                relationship.contains(lowerFilter) ||
                father.contains(lowerFilter) ||
                mother.contains(lowerFilter) ||
                dob.contains(lowerFilter) ||
                gender.contains(lowerFilter) ||
                qualification.contains(lowerFilter) ||
                occupation.contains(lowerFilter);
          }).toList();
        case 'FAMILY':
          List<FamilyInfo> families = (associates as List<dynamic>)
              .map((e) => FamilyInfo.fromJson(e as Map<String, dynamic>))
              .toList();
          return families.where((family) {
            final familyCode = family.familyCode?.toLowerCase() ?? '';
            final familyName = family.familyName?.toLowerCase() ?? '';
            final contact = family.contact?.toLowerCase() ?? '';
            final address = family.address?.toLowerCase() ?? '';
            final headOfFamily = family.headOfFamily?.toLowerCase() ?? '';

            return familyCode.contains(lowerFilter) ||
                familyName.contains(lowerFilter) ||
                contact.contains(lowerFilter) ||
                address.contains(lowerFilter) ||
                headOfFamily.contains(lowerFilter);
          }).toList();
        case 'ASSOCIATION':
          List<AssociationInfo> associations = (associates as List<dynamic>)
              .map((e) => AssociationInfo.fromJson(e as Map<String, dynamic>))
              .toList();
          return associations.where((association) {
            final name = association.name?.toLowerCase() ?? '';
            final type = association.type?.toLowerCase() ?? '';
            final description = association.description?.toLowerCase() ?? '';
            final director = association.director?.toLowerCase() ?? '';
            final patron = association.patron?.toLowerCase() ?? '';

            return name.contains(lowerFilter) ||
                type.contains(lowerFilter) ||
                description.contains(lowerFilter) ||
                director.contains(lowerFilter) ||
                patron.contains(lowerFilter);
          }).toList();
        default:
          return associates;
      }
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
