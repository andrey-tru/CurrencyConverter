import 'package:currency_conversion/app/app.dart';
import 'package:currency_conversion/feature/feature.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RateRepository)
@prod
class NetworkRateRepository implements RateRepository {
  NetworkRateRepository(this.api);

  final AppApi api;

  @override
  Future<RateModel> currentRate() async {
    try {
      final Response<Map<String, dynamic>> response = await api.currentRate();

      final RateModel rateModel = RateModel.fromJson(response.data!);

      return rateModel;
    } catch (_) {
      rethrow;
    }
  }
}
