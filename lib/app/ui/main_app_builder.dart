import 'package:currency_conversion/app/app.dart';
import 'package:currency_conversion/feature/rate/rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBuider implements AppBuilder {
  @override
  Widget buildApp() {
    return const _GlobalProviders(child: RateScreen());
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<RateCubit>(
          create: (BuildContext context) => locator.get<RateCubit>(),
        ),
      ],
      child: MaterialApp(home: child),
    );
  }
}
