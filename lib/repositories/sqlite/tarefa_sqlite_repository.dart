import 'package:trilhaapp/model/tarefa_sqlite_model.dart';
import 'package:trilhaapp/repositories/sqlite/sqlitedatabase.dart';

class TarefaSqliteRepository {
  Future<List<TarefaSqliteModel>> obterDados(bool apenasNaoConcluidos) async {
  List<TarefaSqliteModel> tarefas = [];
  var db = await SQLiteDataBase().obterDataBase();
  var result = await db.rawQuery( apenasNaoConcluidos ? "SELECT id, descricao, concluido FROM tarefas WHERE concluido = 0" : "SELECT id, descricao, concluido FROM tarefas");
  for (var e in result) {
    tarefas.add(TarefaSqliteModel.fromMap(e));
  }
  return tarefas;
}

  Future<void> salvar(TarefaSqliteModel tarefaSqliteModel) async {
  var db = await SQLiteDataBase().obterDataBase();
  await db.insert(
    'tarefas',
    {
      'descricao': tarefaSqliteModel.descricao,
      'concluido': tarefaSqliteModel.concluido ? 1 : 0,
    },
  );
}

  Future<void> atualizar(TarefaSqliteModel tarefaSqliteModel) async {
  var db = await SQLiteDataBase().obterDataBase();
  await db.update(
    'tarefas',
    {
      'descricao': tarefaSqliteModel.descricao,
      'concluido': tarefaSqliteModel.concluido ? 1 : 0,
    },
    where: 'id = ?',
    whereArgs: [tarefaSqliteModel.id],
  );
}

  Future<void> remover(int id) async {
  var db = await SQLiteDataBase().obterDataBase();
  await db.delete(
    'tarefas',
    where: 'id = ?',
    whereArgs: [id],
  );
}
}
