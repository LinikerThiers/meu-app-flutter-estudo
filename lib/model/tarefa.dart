import 'package:flutter/material.dart';

class Tarefa {
  final String _id = UniqueKey().toString();
  String _descricao = "";
  bool _concluido = false;

  Tarefa(this._descricao, this._concluido);

  // String getId() {
  //   return _id;
  // }
  String get id => _id;

  // String getDescricao() {
  //   return _descricao;
  // }
  String get descricao => _descricao;

  // void setDescricao(String descricao) {
  //   _descricao = descricao;
  // }

  set descricao(String descricao) {
    _descricao = descricao;
  }

  // bool getConcluido() {
  //   return _concluido;
  // }

  bool get concluido => _concluido;

  // void setConcluido(bool concluido) {
  //   _concluido = concluido;
  // }

  set concluido (bool concluido) {
    _concluido = concluido;
  }
}