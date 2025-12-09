
import 'package:app_cas_natal/widgets/cursos/direitos_deveres_card_widget.dart';
import 'package:app_cas_natal/widgets/cursos/historia_cas_card_widget.dart';
import 'package:app_cas_natal/widgets/cursos/historia_cultura_card_widget.dart';
import 'package:app_cas_natal/widgets/cursos/letramento_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CursosPage extends StatefulWidget {
  const CursosPage({super.key});

  @override
  State<CursosPage> createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 30),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              CardModuloHistoriaCASWidget(onPressed: () {}),
              SizedBox(height: 15),
              CardModuloHistoriaCulturaWidget(onPressed: () {context.goNamed('HistoriaECulturaSurda');}),
              SizedBox(height: 15),
              CardModuloLetramentoWidget(onPressed: () {}),
              SizedBox(height: 15),
              CardModuloDireitosDeveresWidget(onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
