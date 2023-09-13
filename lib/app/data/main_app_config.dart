import 'package:currency_conversion/app/app.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AppConfig)
@prod
class ProdAppConfig implements AppConfig {
  @override
  String get baseUrl => 'http://api.exchangeratesapi.io/v1';

  @override
  String get host => Environment.prod;
}

@Singleton(as: AppConfig)
@dev
class DevAppConfig implements AppConfig {
  @override
  String get baseUrl => 'http://localhost';

  @override
  String get host => Environment.dev;
}

@Singleton(as: AppConfig)
@test
class TestAppConfig implements AppConfig {
  @override
  String get baseUrl => 'http://_';

  @override
  String get host => Environment.test;
}
