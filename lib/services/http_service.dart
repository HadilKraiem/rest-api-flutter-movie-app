import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/app_config.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;
  late String _baseURL;
  late String _api_key;
  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _baseURL = _config.baseAPIURL;
    _api_key = _config.apiKey;
  }
  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$_baseURL$path';
      Map<String, dynamic> query = {
        'api_key': _api_key,
        'language': 'en-US',
      };
      // if (query != null) {
      //   query.addAll(query);
      // }
      return await dio.get(url, queryParameters: query);
    } on DioException catch (e) {
      print('Unable to perform get request.');
      print('DioException: $e');
      throw e;
    }
  }
}
