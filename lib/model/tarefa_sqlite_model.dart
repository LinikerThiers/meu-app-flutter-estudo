class TarefaSqliteModel {
  int _id = 0;
  String _descricao = "";
  bool _concluido = false;

  TarefaSqliteModel(this._id, this._descricao, this._concluido);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get descricao => _descricao;

  set descricao(String descricao) {
    _descricao = descricao;
  }

  bool get concluido => _concluido;

  set concluido(bool concluido) {
    _concluido = concluido;
  }

  factory TarefaSqliteModel.fromMap(Map<String, dynamic> map) {
  return TarefaSqliteModel(
    map['id'] as int,
    map['descricao'] as String,
    map['concluido'] == 1,
  );
}
}
