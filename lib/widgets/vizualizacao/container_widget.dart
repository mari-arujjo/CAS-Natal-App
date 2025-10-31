import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatefulWidget {
  final Widget child;
  const ContainerWidget({super.key, required this.child});

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cores.cinzaClaro,
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.child,
    );
  }
}
