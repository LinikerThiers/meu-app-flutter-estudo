import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  AppStorageService storage = AppStorageService();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaUsuarioController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool receberPushNotification = false;
  bool temaEscuro = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracaoNomeUsuario();
    alturaUsuarioController.text =
        (await storage.getConfiguracaoAlturaUsuario()).toString();
    receberPushNotification = await storage.getConfiguracaoNotificacao();
    temaEscuro = await storage.getConfiguracaoTemaEscuro();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Configurações"),
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
                  value: receberPushNotification,
                  onChanged: (bool value) {
                    setState(() {
                      receberPushNotification = value;
                    });
                  }),
              SwitchListTile(
                  title: Text("Tema escuro"),
                  activeColor: Colors.purple,
                  activeTrackColor: Colors.purple[400],
                  inactiveThumbColor: Colors.purple[200],
                  inactiveTrackColor: Colors.purple[100],
                  value: temaEscuro,
                  onChanged: (bool value) {
                    setState(() {
                      temaEscuro = value;
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
                        await storage.setConfiguracaoAlturaUsuario(double.parse(
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
                      await storage.setConfiguracaoNomeUsuario(nomeUsuarioController.text);
                      await storage.setConfiguracaoNotificacao(receberPushNotification);
                      await storage.setConfiguracaoTemaEscuro(temaEscuro);
                      if (!mounted) return;
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
