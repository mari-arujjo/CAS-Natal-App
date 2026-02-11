import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/widgets/inputs/input_content_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:flutter/material.dart';

class TopicInputWidget extends StatelessWidget {
  final int index;
  final TextEditingController titleCtrl;
  final TextEditingController contentCtrl;
  final VoidCallback onRemove;

  const TopicInputWidget({
    super.key,
    required this.index,
    required this.titleCtrl,
    required this.contentCtrl,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Cores();
    
    return Card(
      color: cores.backgroundScaffold,
      margin:EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tópico ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onRemove),
              ],
            ),
            Text('Título do Tópico:'),
            InputPadraoWidget(maxLength: 200, controller: titleCtrl, readOnly: false),
            SizedBox(height: 10),
            Text('Conteúdo:'),
            InputContentWidget(maxLength: 10000, controller: contentCtrl),
          ],
        ),
      ),
    );
  }
}