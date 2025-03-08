import 'package:flutter/material.dart';
import 'package:trilhaapp/model/back4app/tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/tarefas_back4app_repository.dart';

class TarefaHttpPage extends StatefulWidget {
  const TarefaHttpPage({super.key});

  @override
  State<TarefaHttpPage> createState() => _TarefaHttpPageState();
}

class _TarefaHttpPageState extends State<TarefaHttpPage> {
  TarefasBack4appRepository tarefaRepository = TarefasBack4appRepository();
  var _tarefasBack4app = TarefasBack4appModel([]);
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    setState(() {
      carregando = true;
    });
    _tarefasBack4app = await tarefaRepository.obterTarefas(apenasNaoConcluidos);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Lista de Tarefas"),
          ),
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
                                await tarefaRepository.criar(
                                    TarefaBack4appModel.criar(
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
                carregando
                    ? SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _tarefasBack4app.tarefas.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var tarefa = _tarefasBack4app.tarefas[index];
                            return Dismissible(
                              onDismissed:
                                  (DismissDirection dismissDirection) async {
                                await tarefaRepository.remover(tarefa.objectId);
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
                                    await tarefaRepository.atualizar(tarefa);
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
          )),
    );
  }
}
