import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class ProgressBarWidget extends StatefulWidget {
  final int progress;
  const ProgressBarWidget({super.key, required this.progress});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: widget.progress/100,
      color: cores.azulEscuro,
      backgroundColor: cores.cinzaClaro,
      minHeight: 6,
      borderRadius: BorderRadius.circular(4),
    );
  }
}
