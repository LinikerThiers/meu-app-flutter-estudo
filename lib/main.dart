import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/model/tarefa_model_hive.dart';
import 'package:trilhaapp/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  var documentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(DadosCadastaisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());
  runApp(const MyApp());
}
