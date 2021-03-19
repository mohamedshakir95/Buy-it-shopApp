
import 'package:flutter/material.dart';

class CustomWidgets {
 CustomWidgets._();
 static buildErrorSnackbar(BuildContext context, String message) {
  Scaffold.of(context)
     .showSnackBar(
    SnackBar(
      content: Text("$message"),
    ),
  );
 }
}