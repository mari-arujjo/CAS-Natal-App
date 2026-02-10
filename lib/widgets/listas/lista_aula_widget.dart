import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class ListaOrdemAulaWidget extends StatefulWidget {
  final ValueChanged<int?>? onChanged;
  final int? initialOrder;

  const ListaOrdemAulaWidget({
    super.key,
    this.onChanged,
    this.initialOrder,
  });

  @override
  State<ListaOrdemAulaWidget> createState() => _ListaOrdemAulaWidgetState();
}

class _ListaOrdemAulaWidgetState extends State<ListaOrdemAulaWidget> {
  int? _selectedOrder;
  final List<int> _orderOptions = List.generate(10, (index) => index + 1);

  @override
  void initState() {
    super.initState();
    _selectedOrder = widget.initialOrder;
  }

  @override
  Widget build(BuildContext context) {
    final cor = Cores();

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Color(0xFF494949), offset: Offset(0, 1))
          ]),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: _selectedOrder,
            dropdownColor: Colors.white,
            isExpanded: true,
            borderRadius: BorderRadius.circular(14),
            hint: Text("Selecione a ordem da aula",
                style: TextStyle(color: cor.azulEscuro)),
            items: _orderOptions.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text("Aula $value",
                    style: TextStyle(color: cor.azulEscuro)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOrder = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
          ),
        ),
      ),
    );
  }
}