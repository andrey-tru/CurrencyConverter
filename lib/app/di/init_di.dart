import 'package:currency_conversion/app/di/init_di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt locator = GetIt.instance;

@InjectableInit()
void initDi(String env) {
  locator.init(environment: env);
}
