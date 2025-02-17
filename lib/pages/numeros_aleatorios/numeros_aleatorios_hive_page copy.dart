import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int? numeroGerado = 0;
  int? quantidadeCliques = 0;
  late Box boxNumerosAleatorios;

  @override
  void initState() {
    super.initState();
    carregarNumeroSalvo();
  }

  void carregarNumeroSalvo() async {
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    try {
      numeroGerado = await boxNumerosAleatorios.get('numeroGerado') ?? 0;
      quantidadeCliques = await boxNumerosAleatorios.get('quantidadeCliques') ?? 0;
      if (mounted) {
      setState(() {});
      }
    } catch (e) {
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar o salvamento")),
      );
    }
    }
  }

  void salvarNumero(int numero) async {
    try {
      boxNumerosAleatorios.put('numeroGerado', numero);
      boxNumerosAleatorios.put('quantidadeCliques', quantidadeCliques);
    } catch (e) {
      debugPrint("Erro ao salvar número: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Hive",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Número Gerado:",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                numeroGerado == null
                    ? "Nenhum numero gerado"
                    : numeroGerado.toString(),
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Quantidade de Cliques:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                quantidadeCliques == null
                    ? "Nenhum clique efetuado"
                    : quantidadeCliques.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            var random = Random();
            int novoNumero = random.nextInt(1000);
            setState(() {
              numeroGerado = novoNumero;
              quantidadeCliques = (quantidadeCliques ?? 0) + 1;
            });
            salvarNumero(novoNumero);
          },
        ),
      ),
    );
  }
}
