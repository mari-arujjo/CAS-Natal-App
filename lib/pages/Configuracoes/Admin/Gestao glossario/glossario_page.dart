import 'package:app_cas_natal/widgets/botoes_padrao/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/fotos/foto_sinal_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_descricao_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/listas/lista_catsinal_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_icon_widget.dart';
import 'package:flutter/material.dart';

class GlossarioPage extends StatefulWidget {
  const GlossarioPage({super.key});

  @override
  State<GlossarioPage> createState() => _GlossarioPageState();
}

class _GlossarioPageState extends State<GlossarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Obrigado')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 20),
          child: Column(
            children: [
              ContainerWidget(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          FotoSinalWidget(height:100),
                          BotaoIconWidget(icon: Icon(Icons.edit)),
                        ],
                      ),
                      SizedBox(height:20),
                      /// NOME DO SINAL
                      Text('Nome do sinal:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, readOnly: false),
                      /// DESCRIÇÃO
                      Text('Descrição:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputDescricaoWidget(maxLength: 150),     
                      /// CATEGORIA
                      Text('Categoria:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      ListaCategoriaSinalWidget(txt: 'Selecione a categoria do sinal'), 
                      SizedBox(height: 20),
                      /// URL
                      Text('URL Sinal:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, readOnly: false),                       
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BotaoLaranjaWidget(txt: 'Salvar', onPressed: (){}, tam: 150),
                  SizedBox(width: 20),
                  BotaoLaranjaWidget(txt: 'Cancelar', onPressed: (){}, tam: 150),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}