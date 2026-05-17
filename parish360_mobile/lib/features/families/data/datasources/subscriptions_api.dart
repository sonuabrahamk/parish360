import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/families/domain/entities/subscription_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'subscriptions_api.g.dart';

@RestApi()
abstract class SubscriptionsApi {
  factory SubscriptionsApi(Dio dio, {String baseUrl}) = _SubscriptionsApi;

  @GET('/family-records/{familyId}/subscriptions')
  Future<List<SubscriptionInfo>> getSubscriptions(
    @Path('familyId') String familyId,
  );
}
