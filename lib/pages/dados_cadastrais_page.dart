import 'package:flutter/material.dart';
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
  var niveis = [];
  var nivelSelecionado = "";

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    super.initState();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                TextButton(
                    onPressed: () {
                      debugPrint(nomeController.text);
                      debugPrint(dataNascimento.toString());
                    },
                    child: Text("Salvar"))
              ],
            ),
          )),
    );
  }
}
