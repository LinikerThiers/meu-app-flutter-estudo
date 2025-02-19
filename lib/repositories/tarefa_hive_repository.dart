import 'package:hive/hive.dart';
import 'package:trilhaapp/model/tarefa_model_hive.dart';

class TarefaHiveRepository {
  static late Box<TarefaHiveModel> _box;

  TarefaHiveRepository._criar();

  static Future<TarefaHiveRepository> carregar() async {
    if (Hive.isBoxOpen('tarefas')) {
      _box = Hive.box('tarefas');
    } else {
      _box = await Hive.openBox('tarefas');
    }
    return TarefaHiveRepository._criar();
  }

  salvar(TarefaHiveModel tarefaHiveModel) {
    _box.add(tarefaHiveModel);
  }

  alterar(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.save();
  }

  excluir(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.delete();
  }

  List<TarefaHiveModel> obterDados(bool naoConcluido) {
    if (naoConcluido) {
      return _box.values
          .cast<TarefaHiveModel>()
          .where((e) => !e.concluido)
          .toList();
    }
    return _box.values.cast<TarefaHiveModel>().toList();
  }
}
