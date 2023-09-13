import 'package:currency_conversion/app/app.dart';
import 'package:flutter/material.dart';

class Notifications {
  static void showSnackBar(BuildContext context, ErrorModel error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: SingleChildScrollView(
          child: Text('Error:${error.message}'),
        ),
      ),
    );
  }
}
