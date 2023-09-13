import 'package:dio/dio.dart';

abstract class AppApi {
  Future<Response<Map<String, dynamic>>> currentRate();
}
