import 'package:currency_conversion/app/app.dart';
import 'package:currency_conversion/feature/feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'rate_state.dart';

part 'rate_cubit.freezed.dart';
part 'rate_cubit.g.dart';

@Singleton()
class RateCubit extends HydratedCubit<RateState> {
  RateCubit(this.rateRepository) : super(const RateState());

  final RateRepository rateRepository;

  Future<void> currentRate() async {
    emit(state.copyWith(isLoading: true));
    try {
      final RateModel rateModel = await rateRepository.currentRate();
      emit(
        state.copyWith(
          isLoading: false,
          rateModel: rateModel,
          fromCurrency: rateModel.rates.keys.first,
          toCurrency: rateModel.rates.keys.first,
          value: '',
          error: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          value: '',
          error: ErrorModel.fromException(error).errorMessage,
        ),
      );
    }
  }

  void currencyConverter(String text) {
    final RateModel rateModel = state.rateModel!;
    final double value = double.parse(text) /
        rateModel.rates[state.fromCurrency]! *
        rateModel.rates[state.toCurrency]!;

    emit(state.copyWith(value: value.toStringAsFixed(2), error: null));
  }

  void chooseFromCurrency(String? value) {
    emit(state.copyWith(fromCurrency: value, value: ''));
  }

  void chooseToCurrency(String? value) {
    emit(state.copyWith(toCurrency: value, value: ''));
  }

  @override
  RateState? fromJson(Map<String, dynamic> json) {
    return RateState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RateState state) {
    return state.toJson();
  }
}
