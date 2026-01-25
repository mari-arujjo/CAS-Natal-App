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
      backgroundColor: WidgetStatePropertyAll(Colors.transparent),
      side: WidgetStatePropertyAll(
        BorderSide(color: cores.cinzaClaro, width: 2),
      ),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      leading: Icon(Icons.search),
      hintText: 'Pesquisar',
      textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.black, fontSize: 15)),
      elevation: WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}