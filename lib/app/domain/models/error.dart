// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';

class ErrorModel {
  ErrorModel({
    required this.message,
    this.errorMessage,
    this.error,
  });

  factory ErrorModel.fromException(dynamic error) {
    if (error is ErrorModel) return error;
    if (error is DioException) {
      try {
        return ErrorModel(
          message:
              error.response?.data['message'].toString() ?? 'error',
          errorMessage:
              error.response?.data['error'].toString() ?? 'error',
          error: error,
        );
      } catch (_) {
        return ErrorModel(message: 'error');
      }
    }
    return ErrorModel(
      message: error.toString(),
      errorMessage: 'error',
    );
  }

  final String message;
  final String? errorMessage;
  final dynamic error;
}
