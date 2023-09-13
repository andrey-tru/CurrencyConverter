import 'package:currency_conversion/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class MainAppRunner implements AppRunner {
  const MainAppRunner(this.env);

  final String env;

  @override
  Future<void> preloadData() async {
    WidgetsFlutterBinding.ensureInitialized();

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );

    initDi(env);

    await dotenv.load();
  }

  @override
  Future<void> run(AppBuilder appBuilder) async {
    await preloadData();

    runApp(appBuilder.buildApp());
  }
}
