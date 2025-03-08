class TarefasBack4appModel {
  List<TarefaBack4appModel> tarefas = [];

  TarefasBack4appModel(this.tarefas);

  TarefasBack4appModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tarefas = <TarefaBack4appModel>[];
      json['results'].forEach((v) {
        tarefas.add(TarefaBack4appModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tarefas.map((v) => v.toJson()).toList();
    return data;
  }
}

class TarefaBack4appModel {
  String objectId = "";
  String descricao = "";
  bool concluido = false;
  String createdAt = "";
  String updatedAt = "";

  TarefaBack4appModel(this.objectId, this.descricao, this.concluido,
      this.createdAt, this.updatedAt);

  TarefaBack4appModel.criar(
    this.descricao,
    this.concluido,
  );

  TarefaBack4appModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    concluido = json['concluido'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
}
