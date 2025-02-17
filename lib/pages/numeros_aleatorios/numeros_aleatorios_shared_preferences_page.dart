import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencesPage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencesPage> createState() => _NumerosAleatoriosSharedPreferencesPageState();
}

class _NumerosAleatoriosSharedPreferencesPageState extends State<NumerosAleatoriosSharedPreferencesPage> {
  int? numeroGerado = 0;
  int? quantidadeCliques = 0;
  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    super.initState();
    carregarNumeroSalvo(); 
  }

  void carregarNumeroSalvo() async {
    try {
        numeroGerado = await storage.getNumerosAleatoriosNumeroAleatorio();
        quantidadeCliques = await storage.getNumerosAleatoriosQuantidadeCliques();
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
      await storage.setNumerosAleatoriosNumeroAleatorio(numero);
      await storage.setNumerosAleatoriosQuantidadeCliques( quantidadeCliques!);
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