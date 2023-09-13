import 'package:currency_conversion/app/app.dart';

abstract class AppRunner {
  Future<void> preloadData();

  Future<void> run(AppBuilder appBuilder);
}
