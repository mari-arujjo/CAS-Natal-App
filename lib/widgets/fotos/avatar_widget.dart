import 'dart:typed_data';
import 'dart:io';
import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  final File? imgFile;
  final Uint8List? imgBytes;
  final double tam;
  const AvatarWidget({super.key, required this.tam,  this.imgFile, this.imgBytes});

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  final cores = Cores();
  @override
  Widget build(BuildContext context) {
    ImageProvider? imagem;
    if(widget.imgFile != null){
      imagem = FileImage(widget.imgFile!);
    } else if (widget.imgBytes != null) {
      imagem = MemoryImage(widget.imgBytes!);
    }

    return CircleAvatar(
      radius: widget.tam,
      backgroundColor: cores.azulEscuro,
      backgroundImage: imagem,
      child: imagem == null ? Icon(Icons.person, size: 40, color: Colors.white) : null
    );
  }
}
