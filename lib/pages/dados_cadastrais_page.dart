import 'package:flutter/material.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({super.key});

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  var linguagemRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];
  var nivelSelecionado = "";
  var linguagensSelecionadas = [];
  double salarioEscolhido = 0;
  int? tempoExperiencia;

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagemRepository.retornaLinguagens();
    super.initState();
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
              "Meus dados",
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
                            dataNascimento = data;
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
                                  selected: nivelSelecionado == nivel,
                                  value: nivel.toString(),
                                  groupValue: nivelSelecionado,
                                  onChanged: (value) {
                                    debugPrint(value.toString());
                                    setState(() {
                                      nivelSelecionado = value.toString();
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
                                  value: linguagensSelecionadas
                                      .contains(linguagem),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        setState(() {
                                          linguagensSelecionadas.add(linguagem);
                                        });
                                      } else {
                                        setState(() {
                                          linguagensSelecionadas
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
                        value: tempoExperiencia,
                        isExpanded: true,
                        items: returnItens(50),
                        onChanged: (value) {
                          setState(() {
                            tempoExperiencia = value;
                          });
                        },
                        hint: Text("Selecione"),
                      ),
                      TextLabel(
                          texto:
                              "Pretenção Salarial: R\$ ${salarioEscolhido.round().toString()}"),
                      Slider(
                          min: 0,
                          max: 10000,
                          value: salarioEscolhido,
                          onChanged: (double value) {
                            debugPrint(value.toString());
                            setState(() {
                              salarioEscolhido = value;
                            });
                          }),
                      TextButton(
                          onPressed: () {
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
                            if (dataNascimento == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Data deve ser preenchida")));
                              return;
                            }
                            if (nivelSelecionado.trim() == "") {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "O nível de experiência deve ser preenchido")));
                              return;
                            }
                            if (linguagensSelecionadas.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Selecione pelo menos uma linguagem")));
                              return;
                            }
                            if (tempoExperiencia == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Preencha a experiência")));
                              return;
                            }
                            if (salarioEscolhido == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "A pretenção salarial deve ser maior que 0")));
                              return;
                            }

                            setState(() {
                                salvando = true;
                              });
                            Future.delayed(Duration(seconds: 3), () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Dados salvo com sucesso!")));
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
