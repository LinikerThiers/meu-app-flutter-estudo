import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/app_images.dart';

class ListViewVPage extends StatefulWidget {
  const ListViewVPage({super.key});

  @override
  State<ListViewVPage> createState() => _ListViewVPageState();
}

class _ListViewVPageState extends State<ListViewVPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImages.plymouth),
          title: Text("Plymouth Argyle"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("The Championship"),
              Text("Inglaterra"),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              if(menu == "opcao2") {}
            },
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(value: "opcao1",child: Text("Opção 1")),
                PopupMenuItem<String>(value: "opcao2",child: Text("Opção 2")),
                PopupMenuItem<String>(value: "opcao3",child: Text("Opção 3")),
              ];
            },
          ),
        ),
        ListTile(
          leading: Image.asset(AppImages.derby),
          title: Text("Plymouth Argyle"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("The Championship"),
              Text("Inglaterra"),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              if(menu == "opcao2") {}
            },
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(value: "opcao1",child: Text("Opção 1")),
                PopupMenuItem<String>(value: "opcao2",child: Text("Opção 2")),
                PopupMenuItem<String>(value: "opcao3",child: Text("Opção 3")),
              ];
            },
          ),
        ),
        ListTile(
          leading: Image.asset(AppImages.exeter),
          title: Text("Plymouth Argyle"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("The Championship"),
              Text("Inglaterra"),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              if(menu == "opcao2") {}
            },
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(value: "opcao1",child: Text("Opção 1")),
                PopupMenuItem<String>(value: "opcao2",child: Text("Opção 2")),
                PopupMenuItem<String>(value: "opcao3",child: Text("Opção 3")),
              ];
            },
          ),
        ),
        ListTile(
          leading: Image.asset(AppImages.bristolRovers),
          title: Text("Plymouth Argyle"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("The Championship"),
              Text("Inglaterra"),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              if(menu == "opcao2") {}
            },
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(value: "opcao1",child: Text("Opção 1")),
                PopupMenuItem<String>(value: "opcao2",child: Text("Opção 2")),
                PopupMenuItem<String>(value: "opcao3",child: Text("Opção 3")),
              ];
            },
          ),
        ),
        ListTile(
          leading: Image.asset(AppImages.shrewsbury),
          title: Text("Plymouth Argyle"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("The Championship"),
              Text("Inglaterra"),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              if(menu == "opcao2") {}
            },
            itemBuilder: (BuildContext bc) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(value: "opcao1",child: Text("Opção 1")),
                PopupMenuItem<String>(value: "opcao2",child: Text("Opção 2")),
                PopupMenuItem<String>(value: "opcao3",child: Text("Opção 3")),
              ];
            },
          ),
        ),
      ],
    );
  }
}
