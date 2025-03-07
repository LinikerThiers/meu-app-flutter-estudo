import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhaapp/model/characters_model.dart';

class MarvelRepository {
  get hex => null;

  Future<CharactersModel> getCharacters() async {
    var dio = Dio();
    var ts = DateTime.now().millisecondsSinceEpoch.toString();
    var publicKey = dotenv.get("MARVELPUBLICKEY");
    var privateKey = dotenv.get("MARVELAPIKEY");
    // print("Public Key: $publicKey");
    // print("Private Key: $privateKey");

    var hash = _generateMd5(ts + privateKey + publicKey);
    // print("Hash da aplicacao: $hash");

    var query = "ts=$ts&apikey=$publicKey&hash=$hash";
    var result =
        await dio.get("http://gateway.marvel.com/v1/public/characters?$query");
    var charactersModel = CharactersModel.fromJson(result.data);
    return charactersModel;
  }

  String _generateMd5(String data) {
    var content = utf8.encode(data);
    var digest = crypto.md5.convert(content);
    return digest.toString();
  }
}
