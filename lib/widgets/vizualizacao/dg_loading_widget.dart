import 'package:flutter/material.dart';
import 'package:app_cas_natal/cores.dart';


class DialogLoadingWidget {
  static void showLoading(BuildContext context) {
    final cores = Cores(); 
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope( 
        canPop: false,
        child: Center(
          child: CircularProgressIndicator(color: cores.laranja), 
        ),
      ),
    );
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}