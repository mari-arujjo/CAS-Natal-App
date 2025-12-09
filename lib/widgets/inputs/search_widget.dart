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
        minWidth: 200, // Largura mínima
        maxWidth: 300, // Largura máxima
        minHeight: 48, // Altura mínima
        maxHeight: 56, // Altura máxima
      ),
      backgroundColor: WidgetStatePropertyAll(cores.cinzaClaro),
      leading: const Icon(Icons.search),
      hintText: 'Pesquisar',
      elevation: const WidgetStatePropertyAll(1),
    );
  }
}
