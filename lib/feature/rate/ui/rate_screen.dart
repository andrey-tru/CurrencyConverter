import 'package:currency_conversion/app/app.dart';
import 'package:currency_conversion/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({super.key});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  RateCubit get rateCubit => locator.get<RateCubit>();

  final TextEditingController controllerFromCurrency = TextEditingController();
  final TextEditingController controllerToCurrency = TextEditingController();

  @override
  void initState() {
    rateCubit.currentRate();
    super.initState();
  }

  Future<void> _showBarModal(
    BuildContext context,
    Map<String, double> rates,
    String? selectedCurrency,
    Function(String? value) onChanged,
  ) async {
    await showBarModalBottomSheet(
      context: context,
      topControl: Container(),
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) => ChooseCurrency(
        rates: rates,
        selectedCurrency: selectedCurrency,
        onChanged: (String? value) {
          Navigator.pop(context);
          onChanged(value);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RateCubit, RateState>(
      bloc: rateCubit,
      listener: (BuildContext context, RateState state) {
        controllerToCurrency.text = state.value;

        if (state.error != null) {
          Notifications.showSnackBar(
            context,
            ErrorModel.fromException(state.error),
          );
        }
      },
      builder: (BuildContext context, RateState state) {
        if (state.isLoading) {
          return const AppLoader();
        }
        final RateModel? rateModel = state.rateModel;

        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            appBar: AppBar(title: const Text('Currency converter')),
            body: SafeArea(
              child: rateModel == null || rateModel.rates.isEmpty
                  ? const Center(child: Text('rates is empty'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          _CurrencyContainer(
                            controller: controllerFromCurrency,
                            selectedCurrency: state.fromCurrency,
                            onPressed: () => _showBarModal(
                              context,
                              rateModel.rates,
                              state.fromCurrency,
                              (String? value) =>
                                  rateCubit.chooseFromCurrency(value),
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.all(30.0),
                            onPressed: () => rateCubit
                                .currencyConverter(controllerFromCurrency.text),
                            icon: const Icon(
                              Icons.keyboard_double_arrow_down,
                              color: Colors.black,
                            ),
                          ),
                          _CurrencyContainer(
                            controller: controllerToCurrency,
                            selectedCurrency: state.toCurrency,
                            readOnly: true,
                            onPressed: () => _showBarModal(
                              context,
                              rateModel.rates,
                              state.toCurrency,
                              (String? value) =>
                                  rateCubit.chooseToCurrency(value),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _CurrencyContainer extends StatelessWidget {
  const _CurrencyContainer({
    required this.controller,
    this.selectedCurrency,
    this.onPressed,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String? selectedCurrency;
  final void Function()? onPressed;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Row(
            children: <Widget>[
              if (selectedCurrency != null) Text(selectedCurrency!),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
