import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/model/tarefa_model_hive.dart';
import 'package:trilhaapp/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:trilhaapp/repositories/comments/comments_repository.dart';
import 'package:trilhaapp/repositories/comments/impl/comments_dio_repository.dart';
import 'package:trilhaapp/repositories/jsonplaceholder_custom_dio.dart';
import 'package:trilhaapp/repositories/posts/impl/posts_dio_repository.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await EasyLocalization.ensureInitialized();
  var documentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(DadosCadastaisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());

  getIt.registerSingleton<JsonPlaceholderCustomDio>(JsonPlaceholderCustomDio());
  getIt.registerSingleton<PostsRepository>(
      PostsDioRepository(getIt<JsonPlaceholderCustomDio>()));
  getIt.registerSingleton<CommentsRepository>(
      CommentsDioRepository(getIt<JsonPlaceholderCustomDio>()));

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('pt', 'BR')],
        path: 'assets/translations',
        fallbackLocale: Locale('pt', 'BR'),
        child: MyApp()),
  );
}
