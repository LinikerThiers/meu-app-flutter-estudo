import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/repositories/dados_cadastrais_reposiroty.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisHivePage extends StatefulWidget {
  const DadosCadastraisHivePage({super.key});

  @override
  State<DadosCadastraisHivePage> createState() =>
      _DadosCadastraisHivePageState();
}

class _DadosCadastraisHivePageState extends State<DadosCadastraisHivePage> {
  late DadosCadastraisReposiroty dadosCadastraisReposiroty;
  var dadosCadastaisModel = DadosCadastaisModel.vazio();
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var linguagemRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagemRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    dadosCadastraisReposiroty = await DadosCadastraisReposiroty.carregar();
    dadosCadastaisModel = dadosCadastraisReposiroty.obterDados();
    nomeController.text = dadosCadastaisModel.nome ?? "";
    dataNascimentoController.text = dadosCadastaisModel.dataNascimento == null
        ? ""
        : dadosCadastaisModel.dataNascimento.toString();
    setState(() {});
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (int i = 0; i <= quantidadeMaxima; i++) {
      itens.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
        ),
      );
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Meus dados Hive",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: salvando
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      TextLabel(texto: "Nome"),
                      TextField(
                        controller: nomeController,
                      ),
                      TextLabel(texto: "Data de nascimento"),
                      TextField(
                        controller: dataNascimentoController,
                        readOnly: true,
                        onTap: () async {
                          var data = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1900, 1, 1),
                              lastDate: DateTime(2026, 12, 31));
                          if (data != null) {
                            dataNascimentoController.text = data.toString();
                            dadosCadastaisModel.dataNascimento = data;
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextLabel(texto: "Nível de experiência"),
                      Column(
                        children: niveis
                            .map((nivel) => RadioListTile(
                                  dense: true,
                                  title: Text(nivel.toString()),
                                  selected: dadosCadastaisModel.nivelExperiencia == nivel,
                                  value: nivel.toString(),
                                  groupValue: dadosCadastaisModel.nivelExperiencia,
                                  onChanged: (value) {
                                    debugPrint(value.toString());
                                    setState(() {
                                      dadosCadastaisModel.nivelExperiencia = value.toString();
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      TextLabel(texto: "Linguagens preferidas"),
                      Column(
                        children: linguagens
                            .map((linguagem) => CheckboxListTile(
                                  dense: true,
                                  title: Text(linguagem.toString()),
                                  value: dadosCadastaisModel.linguagens
                                      .contains(linguagem),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        setState(() {
                                          dadosCadastaisModel.linguagens.add(linguagem);
                                        });
                                      } else {
                                        setState(() {
                                          dadosCadastaisModel.linguagens
                                              .remove(linguagem);
                                        });
                                      }
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      TextLabel(texto: "Tempo de experiência"),
                      DropdownButton<int>(
                        value: dadosCadastaisModel.tempoExperiencia,
                        isExpanded: true,
                        items: returnItens(50),
                        onChanged: (value) {
                          setState(() {
                            dadosCadastaisModel.tempoExperiencia = value ?? 0;
                          });
                        },
                        hint: Text("Selecione"),
                      ),
                      TextLabel(
                          texto:
                              "Pretenção Salarial: R\$ ${dadosCadastaisModel.salario?.round().toString()}"),
                      Slider(
                          min: 0,
                          max: 10000,
                          value: dadosCadastaisModel.salario ?? 0,
                          onChanged: (double value) {
                            debugPrint(value.toString());
                            setState(() {
                              dadosCadastaisModel.salario = value;
                            });
                          }),
                      TextButton(
                          onPressed: () async {
                            setState(() {
                              salvando = false;
                            });
                            if (nomeController.text.trim().length < 3) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Nome deve ser preenchido")));
                              return;
                            }
                            if (dadosCadastaisModel.dataNascimento == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Data deve ser preenchida")));
                              return;
                            }
                            if (dadosCadastaisModel.nivelExperiencia == null || dadosCadastaisModel.nivelExperiencia!.trim() == "") {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "O nível de experiência deve ser preenchido")));
                              return;
                            }
                            if (dadosCadastaisModel.linguagens.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Selecione pelo menos uma linguagem")));
                              return;
                            }
                            
                            if(dadosCadastaisModel.tempoExperiencia == 0 || dadosCadastaisModel.tempoExperiencia == null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Preencha a experiência")));
                            }

                            if (dadosCadastaisModel.salario == null || dadosCadastaisModel.salario == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "A pretenção salarial deve ser maior que 0")));
                              return;
                            }

                            dadosCadastaisModel.nome = nomeController.text;
                            dadosCadastraisReposiroty.salvar(dadosCadastaisModel);

                            setState(() {
                              salvando = true;
                            });
                            Future.delayed(Duration(seconds: 3), () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Dados salvo com sucesso!")));
                              setState(() {
                                salvando = false;
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Salvar"))
                    ],
                  ),
          )),
    );
  }
}
