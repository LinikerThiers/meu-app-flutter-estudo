import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';

class DadosCadastraisReposiroty {
  static late Box _box;

  DadosCadastraisReposiroty._criar();

  static Future<DadosCadastraisReposiroty> carregar() async {
    if (Hive.isBoxOpen('dadosCadastraisModel')) {
      _box = Hive.box('dadosCadastraisModel');
    } else {
      _box = await Hive.openBox('dadosCadastraisModel');
    }
    return DadosCadastraisReposiroty._criar();
  }

  void salvar(DadosCadastaisModel dadosCadastraisModel) {
    _box.put('dadosCadastraisModel', dadosCadastraisModel);
  }

  DadosCadastaisModel obterDados() {
    var dadosCadastrais = _box.get('dadosCadastraisModel');
    if (dadosCadastrais == null) {
      return DadosCadastaisModel.vazio();
    }
    return dadosCadastrais;
  }
}
