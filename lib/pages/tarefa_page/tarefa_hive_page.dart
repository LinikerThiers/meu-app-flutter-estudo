import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_model_hive.dart';
import 'package:trilhaapp/repositories/tarefa_hive_repository.dart';

class TarefaHivePage extends StatefulWidget {
  const TarefaHivePage({super.key});

  @override
  State<TarefaHivePage> createState() => _TarefaHivePageState();
}

class _TarefaHivePageState extends State<TarefaHivePage> {
  late TarefaHiveRepository tarefaRepository;
  var _tarefas = const <TarefaHiveModel>[];
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    tarefaRepository = await TarefaHiveRepository.carregar();
    _tarefas = tarefaRepository.obterDados(apenasNaoConcluidos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              descricaoController.text = "";
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      title: Text("Adicionar tarefa"),
                      content: TextField(
                        controller: descricaoController,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancelar")),
                        TextButton(
                            onPressed: () async {
                              await tarefaRepository.salvar(
                                  TarefaHiveModel.criar(
                                      descricaoController.text, false));
                              Navigator.pop(context);
                              obterTarefas();
                              setState(() {});
                            },
                            child: Text("Salvar")),
                      ],
                    );
                  });
            }),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Apenas não concluidos",
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      value: apenasNaoConcluidos,
                      onChanged: (bool value) {
                        apenasNaoConcluidos = value;
                        obterTarefas();
                      },
                      activeColor: Colors.purple,
                      activeTrackColor: Colors.purple[400],
                      inactiveThumbColor: Colors.purple[200],
                      inactiveTrackColor: Colors.purple[100],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _tarefas.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var tarefa = _tarefas[index];
                    return Dismissible(
                      onDismissed: (DismissDirection dismissDirection) async {
                        tarefaRepository.excluir(tarefa);
                        obterTarefas();
                      },
                      key: Key(tarefa.descricao),
                      background: Container(
                        color: Colors.purple,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(tarefa.descricao),
                        trailing: Switch(
                          onChanged: (bool value) async {
                            tarefa.concluido = value;
                            await tarefaRepository.alterar(tarefa);
                            obterTarefas();
                          },
                          value: tarefa.concluido,
                          activeColor: Colors.purple,
                          activeTrackColor: Colors.purple[400],
                          inactiveThumbColor: Colors.purple[200],
                          inactiveTrackColor: Colors.purple[100],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
