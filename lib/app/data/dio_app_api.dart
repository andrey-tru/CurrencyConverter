import 'package:currency_conversion/app/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  DioAppApi(AppConfig appConfig) {
    final BaseOptions options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
    );

    dio = Dio(options);
  }

  late final Dio dio;

  @override
  Future<Response<Map<String, dynamic>>> currentRate() async {
    return dio.get('/latest?access_key=${dotenv.env['ACCEESS_KEY']}');
  }
}
