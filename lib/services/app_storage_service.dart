import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

enum StorageChaves {
  chavesDadosCadastraisNome,
  chavesDadosCadastraisDataNascimento,
  chavesDadosCadastraisNivelExperiencia,
  chavesDadosCadastraisLinguagens,
  chavesDadosCadastraisTempoExperiencia,
  chavesDadosCadastraisSalario,
  chaveConfiguracaoNomeUsuario,
  chaveConfiguracaoAlturaUsuario,
  chaveConfiguracaoNotificacao,
  chaveConfiguracaoTemaEscuro,
  chaveNumerosAleatoriosQuantidadesCliques,
  chaveNumerosAleatoriosNumeroAleatorio
}

class AppStorageService {

  Future<void> setDadosCadastraisNome(String nome) async {
    await _setString(StorageChaves.chavesDadosCadastraisNome.toString(), nome);
  }

  Future<String> getDadosCadastraisNome() async {
    return _getString(StorageChaves.chavesDadosCadastraisNome.toString());
  }

  Future<void> setDadosCadastraisDataNascimento(DateTime data) async {
    await _setString(StorageChaves.chavesDadosCadastraisDataNascimento.toString(),
        data.toString());
  }

  Future<String> getDadosCadastraisDataNascimento() async {
    return _getString(
        StorageChaves.chavesDadosCadastraisDataNascimento.toString());
  }

  Future<void> setDadosCadastraisNivelExperiencia(String nivelExperiencia) async {
    await _setString(StorageChaves.chavesDadosCadastraisNivelExperiencia.toString(),
        nivelExperiencia);
  }

  Future<String> getDadosCadastraisNivelExperiencia() async {
    return _getString(
        StorageChaves.chavesDadosCadastraisNivelExperiencia.toString());
  }

  Future<void> setDadosCadastraisLinguagens(List<String> linguagem) async {
    await _setStringList(StorageChaves.chavesDadosCadastraisLinguagens.toString(), linguagem);
  }

  Future<List<String>> getDadosCadastraisLinguagens() async {
    return _getStringList(StorageChaves.chavesDadosCadastraisLinguagens.toString());
  }

  Future<void> setDadosCadastraisTempoExperiencia(int tempoExperiencia) async {
    await _setInt(StorageChaves.chavesDadosCadastraisTempoExperiencia.toString(), tempoExperiencia);
  }

  Future<int> getDadosCadastraisTempoExperiencia() async {
    return _getInt(StorageChaves.chavesDadosCadastraisTempoExperiencia.toString());
  }

  Future<void> setDadosCadastraisSalario(double salario) async {
    await _setDouble(StorageChaves.chavesDadosCadastraisSalario.toString(), salario);
  }

  Future<double> getDadosCadastraisSalario() async {
    return _getDouble(StorageChaves.chavesDadosCadastraisSalario.toString());
  }

  Future<void> setConfiguracaoNomeUsuario(String nome) async {
    await _setString(StorageChaves.chaveConfiguracaoNomeUsuario.toString(), nome);
  }

  Future<String> getConfiguracaoNomeUsuario() async {
    return _getString(StorageChaves.chaveConfiguracaoNomeUsuario.toString());
  }

  Future<void> setConfiguracaoAlturaUsuario(double altura) async {
    await _setDouble(StorageChaves.chaveConfiguracaoAlturaUsuario.toString(), altura);
  }

  Future<double> getConfiguracaoAlturaUsuario() async {
    return _getDouble(StorageChaves.chaveConfiguracaoAlturaUsuario.toString());
  }

  Future<void> setConfiguracaoNotificacao(bool value) async {
    await _setBool(StorageChaves.chaveConfiguracaoNotificacao.toString(), value);
  }

  Future<bool> getConfiguracaoNotificacao() async {
    return _getBool(StorageChaves.chaveConfiguracaoNotificacao.toString());
  }

  Future<void> setConfiguracaoTemaEscuro(bool value) async {
    await _setBool(StorageChaves.chaveConfiguracaoTemaEscuro.toString(), value);
  }

  Future<bool> getConfiguracaoTemaEscuro() async {
    return _getBool(StorageChaves.chaveConfiguracaoTemaEscuro.toString());
  }

  Future<void> setNumerosAleatoriosQuantidadeCliques(int cliques) async {
    await _setInt(StorageChaves.chaveNumerosAleatoriosQuantidadesCliques.toString(), cliques);
  }

  Future<int> getNumerosAleatoriosQuantidadeCliques() async {
    return _getInt(StorageChaves.chaveNumerosAleatoriosQuantidadesCliques.toString());
  }

  Future<void> setNumerosAleatoriosNumeroAleatorio(int numero) async {
    await _setInt(StorageChaves.chaveNumerosAleatoriosNumeroAleatorio.toString(), numero);
  }

  Future<int> getNumerosAleatoriosNumeroAleatorio() async {
    return _getInt(StorageChaves.chaveNumerosAleatoriosNumeroAleatorio.toString());
  }

  Future<void> _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  Future<void> _setStringList(String chave, List<String> value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setStringList(chave, value);
  }

  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chave) ?? [];
  }

  Future<void> _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  Future<void> _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }

  Future<void> _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(chave, value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }
}
