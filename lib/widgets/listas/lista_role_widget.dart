import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class ListaRoleWidget extends StatefulWidget {
  final ValueChanged <String?>? onChanged;
  final dynamic txt;
  const ListaRoleWidget({
    super.key, 
    this.onChanged,
    required this.txt
  });

  @override
  State<ListaRoleWidget> createState() => _ListaRoleWidgetState();
}

class _ListaRoleWidgetState extends State<ListaRoleWidget> {
  String? roleSelecionada;
  final List<String> listRole = [
    "1 - Administrador",
    "2 - Padrão",
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

            items: listRole.map((String role){
              return DropdownMenuItem(
                value: role,
                child: Text(role, style: TextStyle(color: cor.azulEscuro)),
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