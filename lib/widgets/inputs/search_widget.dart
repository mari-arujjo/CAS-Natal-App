import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 300,
        minHeight: 48,
        maxHeight: 56,
      ),
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      side: WidgetStatePropertyAll(
        BorderSide(color: cores.cinzaClaro, width: 2),
      ),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      leading: const Icon(Icons.search),
      hintText: 'Pesquisar',
      textStyle: const WidgetStatePropertyAll(TextStyle(color: Color.fromARGB(94, 0, 0, 0))),
      elevation: const WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}