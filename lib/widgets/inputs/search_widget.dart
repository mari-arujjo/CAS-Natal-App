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
      constraints: BoxConstraints(
        minWidth: 200,
        maxWidth: 300,
        minHeight: 48,
        maxHeight: 56,
      ),
      backgroundColor: WidgetStatePropertyAll(cores.cinzaClaro),
      leading: Icon(Icons.search),
      hintText: 'Pesquisar',
      elevation: WidgetStatePropertyAll(1),
    );
  }
}
