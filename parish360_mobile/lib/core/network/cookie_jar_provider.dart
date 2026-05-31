import 'package:cookie_jar/cookie_jar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:parish360_mobile/core/network/cookie_store.dart';

part 'cookie_jar_provider.g.dart';

@riverpod
CookieJar cookieJar(Ref ref) {
  final jar = CookieJar();
  // expose created jar globally for fallback cleanup
  CookieStore.cookieJar = jar;
  return jar;
}
