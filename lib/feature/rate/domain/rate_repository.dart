import 'package:currency_conversion/feature/feature.dart';

abstract class RateRepository {
  Future<RateModel> currentRate();
}
