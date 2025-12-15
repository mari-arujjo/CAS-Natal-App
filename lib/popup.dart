// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:app_cas_natal/cores.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopUp {
  final cor =  Cores();

  void PopUpAlert(BuildContext context, Object erro) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atenção!'),
          content: Text(erro.toString()),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text('Ok', style: TextStyle(color: cor.azulEscuro)),
            ),
          ],
        );
      },
    );
  }

  void PopUpSair(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sair'),
          content: const Text('Tem certeza que deseja sair?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Não', style: TextStyle(color: cor.azulEscuro)),
            ),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text('Sim', style: TextStyle(color: cor.azulEscuro)),
            ),
          ],
        );
      },
    );
  }
  

  ///////////// CRUD ///////////////////////////////////////////////////////////////////////////////////////////////
  void PopUpSalvar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastrado'),
          content: const Text('Cadastro realizado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.pop();
              },
              child: Text('Ok', style: TextStyle(color: cor.azulEscuro)),
            ),
          ],
        );
      },
    );
  }
  void PopUpAlterado(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alterado'),
          content: const Text('Registro alterado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.pop();
              },
              child: Text('Ok', style: TextStyle(color: cor.azulEscuro)),
            ),
          ],
        );
      },
    );
  }
  void PopUpExcluido(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluído'),
          content: const Text('Registro excluído com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.pop();
              },
              child: Text('Ok', style: TextStyle(color: cor.azulEscuro)),
            ),
          ],
        );
      },
    );
  }

  /////////// MATRICULA /////////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> PopUpFazerMatricula (BuildContext context, String courseName) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar matrícula'),
          content: Text('Você confirma a matrícula no curso "$courseName"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar', style: TextStyle(color: cor.azulEscuro)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirmar', style: TextStyle(color: cor.azulEscuro)),
            ),
          ],
        );
      },
    ) ??
    false;
  }
  Future<bool> PopUpCancelarMatricula (BuildContext context, String courseName) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar matrícula'),
          content: Text('Você confirma a matrícula no curso "$courseName"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar', style: TextStyle(color: cor.azulEscuro)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirmar', style: TextStyle(color: cor.azulEscuro)),
            ),
          ],
        );
      },
    ) ??
    false;
  }

  
}
