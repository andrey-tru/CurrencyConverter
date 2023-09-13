import 'package:flutter/material.dart';

class ChooseCurrency extends StatelessWidget {
  const ChooseCurrency({
    super.key,
    required this.rates,
    this.selectedCurrency,
    required this.onChanged,
  });

  final Map<String, double> rates;
  final String? selectedCurrency;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          for (final String item in rates.keys)
            ListTile(
              title: Text(item),
              leading: Radio<String>(
                groupValue: selectedCurrency,
                value: item,
                onChanged: onChanged,
              ),
            ),
        ],
      ),
    );
  }
}
