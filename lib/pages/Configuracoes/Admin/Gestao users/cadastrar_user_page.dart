import 'package:app_cas_natal/widgets/botoes/bt_icon_widget.dart';
import 'package:app_cas_natal/widgets/botoes/bt_laranja_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_senha_widget.dart';
import 'package:app_cas_natal/widgets/inputs/input_widget.dart';
import 'package:app_cas_natal/widgets/listas/lista_role_widget.dart';
import 'package:app_cas_natal/widgets/vizualizacao/container_widget.dart';
import 'package:app_cas_natal/widgets/fotos/avatar_widget.dart';
import 'package:flutter/material.dart';


class CadastrarUserPage extends StatefulWidget {
  const CadastrarUserPage({super.key});

  @override
  State<CadastrarUserPage> createState() => _CadastrarUserPageState();
}

class _CadastrarUserPageState extends State<CadastrarUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de usuário')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  AvatarWidget(tam: 60),
                  BotaoIconWidget(icon: Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 20),
              ContainerWidget(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// NOME
                      Text('Nome:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 50, readOnly: false),
                      /// USERNAME
                      Text('Usuário:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 20, readOnly: false),
                      /// EMAIL
                      Text('Email:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputPadraoWidget(maxLength: 100, readOnly: false),  
                      /// ROLE
                      Text('Role:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      ListaRoleWidget(txt: 'Selecione a função do user no sistema'), 
                      SizedBox(height: 20),
                      /// SENHA
                      Text('Senha:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputSenhaWidget(maxLength: 20),
                      /// CONFIRMAR SENHA
                      Text('Confirmar senha:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5),
                      InputSenhaWidget(maxLength: 20),                              
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