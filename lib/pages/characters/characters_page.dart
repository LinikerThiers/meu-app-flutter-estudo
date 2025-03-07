import 'package:flutter/material.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:trilhaapp/repositories/marvel/marvel_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  ScrollController _scrollController = ScrollController();
  late MarvelRepository marvelRepository;
  CharactersModel charactersModel = CharactersModel();
  int offset = 0;
  var carregando = false;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      var posicaoParaPaginar =
          _scrollController.position.maxScrollExtent * 0.95;
      if (_scrollController.position.pixels > posicaoParaPaginar) {
        carregarDados();
      }
    });
    marvelRepository = MarvelRepository();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    if (carregando) return;
    if (charactersModel.data == null || charactersModel.data!.results == null) {
      charactersModel = await marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        carregando = true;
      });
      offset = offset + charactersModel.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      charactersModel.data!.results!.addAll(tempList.data!.results!);
      carregando = false;
    }
    setState(() {});
  }

  int retornaQuantidadeTotal() {
    try {
      return charactersModel.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int retornaQuantidadeAtual() {
    try {
      return offset + charactersModel.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
            "Heróis: ${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: (charactersModel.data == null ||
                        charactersModel.data!.results == null)
                    ? 0
                    : charactersModel.data!.results!.length,
                itemBuilder: (_, int index) {
                  var characters = charactersModel.data!.results![index];
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          "${characters.thumbnail!.path!}.${characters.thumbnail!.extension!}",
                          height: 100,
                          width: 100,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  characters.name!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(characters.description!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          carregando
              ? ElevatedButton(
                  onPressed: null,
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    ));
  }
}
