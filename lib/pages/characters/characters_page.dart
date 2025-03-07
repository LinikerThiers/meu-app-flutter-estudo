import 'package:flutter/material.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:trilhaapp/repositories/marvel/marvel_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late MarvelRepository marvelRepository;
  CharactersModel charactersModel = CharactersModel();

  @override
  void initState() {
    // TODO: implement initState
    marvelRepository = MarvelRepository();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    charactersModel = await marvelRepository.getCharacters();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
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
                    Image.network("${characters.thumbnail!.path!}.${characters.thumbnail!.extension!}", height: 100, width: 100,),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(characters.name!, style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),),
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
    ));
  }
}
