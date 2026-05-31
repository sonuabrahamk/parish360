import 'package:dio/dio.dart';
import 'package:parish360_mobile/features/configurations/domain/entities/parish_info.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'parish_api.g.dart';

@RestApi()
abstract class ParishApi {
  factory ParishApi(Dio dio, {String baseUrl}) = _ParishApi;

  @GET('/configurations/parish')
  Future<ParishInfo> getParishInfo();

  @PATCH('/configurations/parish')
  Future<ParishInfo> updateParishInfo(@Body() ParishInfo parishInfo);

}