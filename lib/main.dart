import 'package:currency_conversion/app/app.dart';

void main() {
  const String env = String.fromEnvironment('env', defaultValue: 'prod');
  const MainAppRunner runner = MainAppRunner(env);
  final MainAppBuider builder = MainAppBuider();

  runner.run(builder);
}
