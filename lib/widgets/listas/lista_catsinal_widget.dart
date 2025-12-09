import 'package:flutter/material.dart';
import 'package:app_cas_natal/cores.dart';


class ListaCategoriaSinalWidget extends StatefulWidget {
  final ValueChanged <String?>? onChanged;
  final dynamic txt;
  const ListaCategoriaSinalWidget({
    super.key, 
    this.onChanged,
    required this.txt
  });

  @override
  State<ListaCategoriaSinalWidget> createState() => _ListaCategoriaSinalWidgetState();
}

class _ListaCategoriaSinalWidgetState extends State<ListaCategoriaSinalWidget> {
  String? roleSelecionada;
  final List<String> listCategoria = [
    "Emoções e comunicação",
    "Sinais regionais do RN",
    "Pessoas e profissões",
    "Verbos e adjetivos",
    "Mídia e tecnolgia",
    "Clima e natureza"
  ];

  @override
  Widget build(BuildContext context) {
    final cor = Cores();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF494949),
            offset: Offset(0, 1)
          )
        ]
      ),

      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: roleSelecionada,
            dropdownColor: Colors.white,
            isExpanded: true,
            hint: Text(widget.txt, style: TextStyle(color: cor.azulEscuro)),

            items: listCategoria.map((String categoria){
              return DropdownMenuItem(
                value: categoria,
                child: Text(categoria, style: TextStyle(color: cor.azulEscuro)),
                );
              }).toList(),

            onChanged:(value) {
              setState(() {
                roleSelecionada = value;
              });
              if(widget.onChanged != null){
                widget.onChanged!(value);
              }
            },

          ),
        ),
      )
    );
  } 
}