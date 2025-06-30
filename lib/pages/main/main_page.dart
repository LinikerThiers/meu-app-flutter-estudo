import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/contador/contador_page.dart';
import 'package:trilhaapp/pages/image_assets.dart';
import 'package:trilhaapp/pages/list_view_horizontal_page.dart';
import 'package:trilhaapp/pages/list_view_v.dart';
import 'package:trilhaapp/pages/percent_indicator_page.dart';
// import 'package:trilhaapp/pages/tarefa_page/tarefa_sqlite_page.dart';
import 'package:trilhaapp/pages/consulta_cep.dart';
import 'package:trilhaapp/service/dark_mode_service.dart';
import 'package:trilhaapp/shared/widgets/custom_drawer.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

//Para usar o outro exemplo usa  - class _MainPageState extends State<MainPage> with TickerProviderStateMixin

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 0);

  // late TabController pageController;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   pageController = TabController(initialIndex: 0, length: 5, vsync: this);
  // }

  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    // var darkModeService = Provider.of<DarkModeService>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Wallet Wise",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            Center(child: Text("Dark Mode")),
            Consumer<DarkModeService>(
              builder: (_, darkModeService, widget) {
                return Switch(
                    value: darkModeService.darkMode,
                    onChanged: (bool value) {
                      darkModeService.darkMode = !darkModeService.darkMode;
                    });
              }
            )
          ],
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              //Para usar o outro exemplo usa o TabView
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                  debugPrint(value.toString());
                }, //pode vizualizar páginas arrastando
                children: [
                  ContadorPage(),
                  ConsultaCEP(),
                  CardPage(),
                  ImageAssetsPage(),
                  ListViewVPage(),
                  ListViewHorizontal(),
                  PercentIndicatorPage(),
                  // TarefaSQLitePage(),
                ],
              ),
            ),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  pageController.jumpToPage(value);
                },
                currentIndex: posicaoPagina,
                items: [
                  BottomNavigationBarItem(
                      label: "Contador", icon: Icon(Icons.add)),
                  BottomNavigationBarItem(
                      label: "HTTP", icon: Icon(Icons.place)),
                  BottomNavigationBarItem(
                      label: "Pag1", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(label: "Pag2", icon: Icon(Icons.add)),
                  BottomNavigationBarItem(
                      label: "Pag3", icon: Icon(Icons.list)),
                  BottomNavigationBarItem(
                      label: "Pag4", icon: Icon(Icons.image)),
                  BottomNavigationBarItem(
                      label: "Pag5", icon: FaIcon(FontAwesomeIcons.spinner)),
                ]),
          ],
        ),
        // bottomNavigationBar: ConvexAppBar(
        //   backgroundColor: Colors.purple,
        //   items: [
        //     TabItem(icon: Icons.place, title: 'HTTP'),
        //     TabItem(icon: Icons.home, title: 'Pag1'),
        //     TabItem(icon: Icons.add, title: 'Pag2'),
        //     TabItem(icon: Icons.list, title: 'Pag3'),
        //     TabItem(icon: Icons.image, title: 'Pag4'),
        //     TabItem(icon: Icons.autorenew, title: 'Pag5'),
        //   ],
        //   onTap: (int i) => pageController.index = i,
        //   controller: pageController,
        // )
      ),
    );
  }
}
