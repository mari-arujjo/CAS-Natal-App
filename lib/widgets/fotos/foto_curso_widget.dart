import 'dart:io';
import 'dart:typed_data';
import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class FotoCursoWidget extends StatefulWidget {
  final File? imgFile;
  final Uint8List? imgBytes;
  final double height;

  const FotoCursoWidget({
    super.key,
    required this.height,
    this.imgFile,
    this.imgBytes,
  });

  @override
  State<FotoCursoWidget> createState() => _FotoCursoWidgetState();
}

class _FotoCursoWidgetState extends State<FotoCursoWidget> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    ImageProvider? imagem;
    if (widget.imgFile != null) {
      imagem = FileImage(widget.imgFile!);
    } else if (widget.imgBytes != null) {
      imagem = MemoryImage(widget.imgBytes!);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          color: cores.azulEscuro,
          image: imagem != null
              ? DecorationImage(
                  image: imagem,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imagem == null
            ? Center(
                child: Icon(
                  Icons.school,
                  size: 40,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
