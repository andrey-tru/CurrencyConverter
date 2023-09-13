import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate.freezed.dart';
part 'rate.g.dart';

@freezed
class RateModel with _$RateModel {
  const factory RateModel({
    @JsonKey(name: 'base') required String baseCurrency,
    required Map<String, double> rates,
  }) = _RateModel;

  factory RateModel.fromJson(Map<String, dynamic> json) =>
      _$RateModelFromJson(json);

  @override
  Map<String, dynamic> toJson();
}
