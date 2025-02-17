import 'package:flutter/material.dart';
import 'package:trilhaapp/model/configuracoes_model.dart';
import 'package:trilhaapp/repositories/configuracoes_repository.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  late ConfiguracoesRepository configuracoesRepository;
  ConfiguracoesModel configuracoesModel = ConfiguracoesModel.vazio();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaUsuarioController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaUsuarioController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Configurações Hive"),
        ),
        body: Container(
          width: double.infinity,
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 35,
                alignment: Alignment.center,
                child: TextField(
                    controller: nomeUsuarioController,
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple[50],
                        contentPadding: EdgeInsets.only(top: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.person_2,
                          color: Colors.purple,
                        ),
                        hintText: "Usuário",
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ))),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 35,
                alignment: Alignment.center,
                child: TextField(
                    keyboardType: TextInputType.number,
                    controller: alturaUsuarioController,
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple[50],
                        contentPadding: EdgeInsets.only(top: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.straighten,
                          color: Colors.purple,
                        ),
                        hintText: "Altura",
                        hintStyle: TextStyle(
                          color: Colors.purple,
                        ))),
              ),
              SizedBox(
                height: 10,
              ),
              SwitchListTile(
                  title: Text("Receber notificações"),
                  activeColor: Colors.purple,
                  activeTrackColor: Colors.purple[400],
                  inactiveThumbColor: Colors.purple[200],
                  inactiveTrackColor: Colors.purple[100],
                  value: configuracoesModel.notificacao,
                  onChanged: (bool value) {
                    setState(() {
                      configuracoesModel.notificacao = value;
                    });
                  }),
              SwitchListTile(
                  title: Text("Tema escuro"),
                  activeColor: Colors.purple,
                  activeTrackColor: Colors.purple[400],
                  inactiveThumbColor: Colors.purple[200],
                  inactiveTrackColor: Colors.purple[100],
                  value: configuracoesModel.temaEscuro,
                  onChanged: (bool value) {
                    setState(() {
                      configuracoesModel.temaEscuro = value;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        configuracoesModel.altura = (double.parse(
                            alturaUsuarioController.text.replaceAll(",", ".")));
                      } catch (e) {
                        if (!mounted) return;
                        showDialog(
                            context: context,
                            builder: (bc) {
                              return AlertDialog(
                                title: Text("Meu App"),
                                content:
                                    Text("Favor informar uma altura válida"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"))
                                ],
                              );
                            });
                        return;
                      }
                      configuracoesModel.nomeUsuario =
                          nomeUsuarioController.text;
                      if (!mounted) return;
                      configuracoesRepository.salvar(configuracoesModel);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.purple,
                      ),
                    ),
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
