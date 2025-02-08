import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/dados_cadastrais_page.dart';
import 'package:trilhaapp/pages/pagina1.dart';
import 'package:trilhaapp/pages/pagina2.dart';
import 'package:trilhaapp/pages/pagina3.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Wallet Wise",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      width: double.infinity,
                      child: Text("Dados Cadastrais")),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DadosCadastraisPage(
                              texto: "Meus dados",
                              dados: [
                                "Nome", "Endereço", "Telefone",
                              ],
                            )));
                  },
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      width: double.infinity,
                      child: Text("Configurações")),
                  onTap: () {},
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      width: double.infinity,
                      child: Text("Termo de uso e privacidade")),
                  onTap: () {},
                ),
                Divider(),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                  debugPrint(value.toString());
                }, //pode vizualizar páginas arrastando
                children: [
                  Pagina1Page(),
                  Pagina2Page(),
                  Pagina3Page(),
                ],
              ),
            ),
            BottomNavigationBar(
              onTap: (value) {
                controller.jumpToPage(value);
              },
              currentIndex: posicaoPagina,
              items: [
              BottomNavigationBarItem(
                label: "Pag1",
                icon: Icon(Icons.home)
                ),
                BottomNavigationBarItem(
                label: "Pag2",
                icon: Icon(Icons.add)
                ),
                BottomNavigationBarItem(
                label: "Pag3",
                icon: Icon(Icons.person)
                )
            ]),
          ],
        ),
      ),
    );
  }
}
