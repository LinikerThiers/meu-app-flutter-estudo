import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int? numeroGerado = 0;
  int? quantidadeCliques = 0;
  final CHAVE_QUANTIDADE_CLIQUES = "quantidade_cliques";
  final CHAVE_NUMERO_ALEATORIO = "numero_aleatorio";
  late SharedPreferences storage;

  @override
  void initState() {
    super.initState();
    carregarNumeroSalvo(); 
  }

  void carregarNumeroSalvo() async {
    try {
      storage = await SharedPreferences.getInstance();
      setState(() {
        numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO) ?? 0;
        quantidadeCliques = storage.getInt(CHAVE_QUANTIDADE_CLIQUES) ?? 0;
      });
    } catch (e) {
      print("Erro ao carregar número salvo: $e");
    }
  }

  void salvarNumero(int numero) async {
    try {
      storage = await SharedPreferences.getInstance();
      await storage.setInt(CHAVE_NUMERO_ALEATORIO, numero);
      await storage.setInt(CHAVE_QUANTIDADE_CLIQUES, quantidadeCliques!);
    } catch (e) {
      print("Erro ao salvar número: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Gerador de Números",
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
                numeroGerado == null ? "Nenhum numero gerado" : numeroGerado.toString(),
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
                quantidadeCliques == null ? "Nenhum clique efetuado" : quantidadeCliques.toString(),
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
              quantidadeCliques = 
              (quantidadeCliques ?? 0) + 1; 
            });
            salvarNumero(novoNumero); 
          },
        ),
      ),
    );
  }
}