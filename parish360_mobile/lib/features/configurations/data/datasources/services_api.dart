import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/service_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'services_api.g.dart';

@RestApi()
abstract class ServicesApi {
  factory ServicesApi(Dio dio, {String baseUrl}) = _ServicesApi;

  @GET('/configurations/services')
  Future<List<ServiceInfo>> getAllServices();

  @POST('/configurations/services')
  Future<ServiceInfo> createService(@Body() ServiceInfo serviceInfo);

  @GET('/configurations/services/{serviceId}')
  Future<ServiceInfo> getServiceInfo(@Path('serviceId') String serviceId);

  @DELETE('/configurations/services/{serviceId}')
  Future<void> deleteService(@Path('serviceId') String serviceId);
}
