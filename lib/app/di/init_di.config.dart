// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:currency_conversion/app/app.dart' as _i3;
import 'package:currency_conversion/app/data/dio_app_api.dart' as _i5;
import 'package:currency_conversion/app/data/main_app_config.dart' as _i4;
import 'package:currency_conversion/feature/feature.dart' as _i6;
import 'package:currency_conversion/feature/rate/data/network_rate_repository.dart'
    as _i7;
import 'package:currency_conversion/feature/rate/domain/rate_state/rate_cubit.dart'
    as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _prod = 'prod';
const String _dev = 'dev';
const String _test = 'test';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AppConfig>(
      _i4.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.singleton<_i3.AppConfig>(
      _i4.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i3.AppConfig>(
      _i4.TestAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i3.AppApi>(_i5.DioAppApi(gh<_i3.AppConfig>()));
    gh.factory<_i6.RateRepository>(
      () => _i7.NetworkRateRepository(gh<_i3.AppApi>()),
      registerFor: {_prod},
    );
    gh.singleton<_i8.RateCubit>(_i8.RateCubit(gh<_i6.RateRepository>()));
    return this;
  }
}
