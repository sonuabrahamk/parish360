import 'package:cookie_jar/cookie_jar.dart';

/// Global holder for the app CookieJar instance so non-Riverpod code
/// can still clear cookies when necessary (fallback path).
class CookieStore {
  CookieStore._();

  static CookieJar? cookieJar;
}
