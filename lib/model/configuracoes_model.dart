class ConfiguracoesModel {
  String _nomeUsuario = "";
  double _altura = 0;
  bool _notificacao = false;
  bool _temaEscuro = false;

  ConfiguracoesModel.vazio() {
    _nomeUsuario = "";
    _altura = 0;
    _notificacao = false;
    _temaEscuro = false;
  }

  ConfiguracoesModel(this._nomeUsuario, this._altura, this._notificacao, this._temaEscuro);

  String get nomeUsuario => _nomeUsuario;

  set nomeUsuario(String value) {
    _nomeUsuario = value;
  }

  double get altura => _altura;
  
  set altura(double value) {
    _altura = value;
  }

  bool get notificacao => _notificacao;
  
  set notificacao(bool value) {
    _notificacao = value;
  }

  bool get temaEscuro => _temaEscuro;
  
  set temaEscuro(bool value) {
    _temaEscuro = value;
  }


}