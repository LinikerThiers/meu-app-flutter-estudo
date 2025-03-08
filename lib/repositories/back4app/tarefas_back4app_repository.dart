import 'package:trilhaapp/model/back4app/tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/back4app_custom_dio.dart';

class TarefasBack4appRepository {
  final _customDio = Back4appCustomDio();

  TarefasBack4appRepository() {
  }

  Future<TarefasBack4appModel> obterTarefas(bool naoConcluidas) async {
    var url = "/Tarefas";
    if (naoConcluidas) {
      url = "$url?where={\"concluido\":false}";
    }
    var result = await _customDio.dio.get(url);
    return TarefasBack4appModel.fromJson(result.data);
  }

  Future<void> criar(TarefaBack4appModel tarefa) async {
    try {
      await _customDio.dio.post("/Tarefas", data: tarefa.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizar(TarefaBack4appModel tarefa) async {
    try {
      await _customDio.dio.put("/Tarefas/${tarefa.objectId}",
          data: tarefa.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _customDio.dio.delete("/Tarefas/${objectId}");
    } catch (e) {
      throw e;
    }
  }
}
