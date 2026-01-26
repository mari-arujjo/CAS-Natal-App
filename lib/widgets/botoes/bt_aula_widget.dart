import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class AulaTile extends StatefulWidget {
  final int index;
  final String title;
  final VoidCallback onTap;

  const AulaTile({
    super.key,
    required this.index,
    required this.title,
    required this.onTap,
  });

  @override
  State<AulaTile> createState() => _AulaTileState();
}

class _AulaTileState extends State<AulaTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cores = Cores();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _isHovered ? cores.cinzaClaro: Colors.white,
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cores.laranja,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  "${widget.index}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(221, 0, 0, 0),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right, 
                color: Colors.black,
              ),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}