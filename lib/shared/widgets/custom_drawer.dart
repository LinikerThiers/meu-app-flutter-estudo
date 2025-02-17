import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/configuracoes/configuracoes_hive_page.dart';
// import 'package:trilhaapp/pages/configuracoes/configuracoes_shared_preferences_page.dart';
import 'package:trilhaapp/pages/dados_cadastrais_page.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/numeros_aleatorios/numeros_aleatorios_hive_page%20copy.dart';
// import 'package:trilhaapp/pages/numeros_aleatorios/numeros_aleatorios_shared_preferences_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  context: context,
                  builder: (BuildContext bc) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                      child: Wrap(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            title: Text("Camera"),
                            leading: Icon(Icons.camera_alt),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            title: Text("Galeria"),
                            leading: Icon(Icons.photo_album),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.purple),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage("lib/images/foto_perfil_1.png"),
                ),
                accountName: Text("Liniker Thiers"),
                accountEmail: Text("email@email.com")),
          ),
          InkWell(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Dados Cadastrais"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DadosCadastraisPage()));
            },
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Configurações"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (bc) => ConfiguracoesHivePage()));
            },
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Termo de uso e privacidade"),
                  ],
                )),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      child: Column(
                        children: [
                          Text(
                            "Termo de uso e privacidade",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.casino),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Gerador de Números"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, 
              MaterialPageRoute(builder: (bc) => NumerosAleatoriosHivePage())
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Sair"),
                  ],
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      alignment: Alignment.centerLeft,
                      elevation: 8,
                      title: Text(
                        "Meu App",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Você sairá do App!"),
                          Text("Deseja sair do App?"),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Não")),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text("Sim")),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
