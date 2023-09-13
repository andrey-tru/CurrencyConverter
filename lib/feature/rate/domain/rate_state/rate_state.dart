part of 'rate_cubit.dart';

@freezed
class RateState with _$RateState {
  const factory RateState({
    @Default(false) bool isLoading,
    String? error,
    RateModel? rateModel,
    String? fromCurrency,
    String? toCurrency,
    @Default('') String value,
  }) = _RateState;

  factory RateState.fromJson(Map<String, dynamic> json) =>
      _$RateStateFromJson(json);
}
