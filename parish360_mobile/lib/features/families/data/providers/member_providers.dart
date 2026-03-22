import 'package:parish360_mobile/core/network/dio_provider.dart';
import 'package:parish360_mobile/features/families/data/datasources/member_api.dart';
import 'package:parish360_mobile/features/families/data/repositories/member_repository_impl.dart';
import 'package:parish360_mobile/features/families/domain/repositories/member_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_providers.g.dart';

@riverpod
MemberApi memberApi(Ref ref) {
  return MemberApi(ref.watch(dioProvider));
}

@riverpod
MemberRepository memberRepository(Ref ref) {
  return MemberRepositoryImpl(ref.watch(memberApiProvider));
}